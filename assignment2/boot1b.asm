;;;  Initial boot loader
;;;
org     0x7c00
        jmp     start

;;; print a message
print:
        mov     ah,0x0e
.loop
        mov     al,[bx]
        cmp     al,0x00
        jnz     .next
        ret
.next
        int     10h             ; BIOS call
        inc     bx
        jmp     .loop

;;; read one cyliner
;;; ax: destination address / 0x10
;;; ch: cyliner (0..)
read_cylinder:
        mov     es,ax           ; destination address = [es:bx]
        mov     bx,0
        mov     dl,0            ; drive 0 
        mov     dh,0            ; head 0
        mov     cl,1            ; from sector 1
        mov     ah,0x02
        mov     al,18           ; all 18 sectors
        int     0x13            ; BIOS call
        jnc     .next
        mov     bx,read_err
        call    print
        hlt                     ; error
.next
        ret

;;; wait until the keyboard is ready
wait_kdb:
        in      al,0x64
        and     al,0x02
        in      al,0x60
        jnz     wait_kdb
        ret

;;; initial loader
;;;
start:
        ;; wait until any key is pressed
        mov     bx,press_key
        call    print
        mov     ah,0
        int     0x16

        ;; initialize segment registers
        mov     ax,cs
        mov     ds,ax
        mov     es,ax
        mov     ax,0x6000
        mov     sp,ax

        mov     ax,0x0800       ; address
        mov     ch,0            ; cyliner 0
        call    read_cylinder 

        mov     al,0xff         ; disable interrupt
        out     0x21,al
        nop
        out     0xa1,al
        cli

        call    wait_kdb        ; enable A20
        mov     al,0xd1
        out     0x64,al
        call    wait_kdb
        mov     al,0xdf
        out     0x60,al
        call    wait_kdb

        mov     al,0x13         ; VGA 320x200, 8bit color
        mov     ah,0x00
        int     0x10            ; BIOS call

        ;; initialize GDT and IDT
        mov     bx,gdt_ptr
        lgdt    [bx]            ; set GDT

        mov     dword edx,0x90000      ; IDT 0x90000..0x907ff
.loop1:
        mov     dword [edx], 0
        mov     dword [edx+4], 0
	add     dword edx,8
        cmp     edx,0x90800
        jne     .loop1

        ;; register a handler for INT21 (IRQ1)
        mov     dword edx,0x90000+8*0x21 ; INT 0x21 (IRQ1)
        mov     word [edx],.handler_irq1
        mov     word [edx+2],8          ; segment selector
        mov     byte [edx+4],0          ; always 0
        mov     byte [edx+5],0x8e       ; 0x8e | (ring << 5)
        mov     word [edx+6],0          ; upper 16bits of .handler_irq

        mov     bx,idt_ptr
        lidt    [bx]            ; set IDT

        ;; initialize PIC (Programmable Interrupt Controller)
        mov     al,0x11
        out     0x20,al         ; PIC0 ICW1
	nop
	mov     al,0x20
        out     0x21,al         ; PIC0 ICW2: IRQ0-7 causes INT 0x20-27
	nop
	mov     al,0x04
        out     0x21,al         ; PIC0 ICW3
	nop
	mov     al,0x01
        out     0x21,al         ; PIC0 ICW4
	nop

	mov     al,0x11
        out     0xa0,al         ; PIC1 ICW1
	nop
	mov     al,0x28
        out     0xa1,al         ; PIC1 ICW2: IRQ8-15 causes INT 0x28-2f
	nop
	mov     al,0x02
        out     0xa1,al         ; PIC1 ICW3
	nop
	mov     al,0x01
        out     0xa1,al         ; PIC1 ICW4
	nop

        mov     al,0xfb
        out     0x21,al         ; PIC0 IMR (disable all interrupts except PIC1)
	nop
	mov     al,0xff
        out     0xa1,al         ; PIC1 IMR (disable all interrupts)
	nop

        ;; switch to 32bit protected mode
        mov     eax,cr0
        and     eax,0x7fffffff  ; reset PG (paging)
        or      eax,1           ; set PE (protected mode enagble)
        mov     cr0,eax
        jmp     .next           ; clear the pipe line
.next:
        mov     ax,0x10         ; ds,es,ss := 0x10
        mov     ds,ax
        mov     es,ax
        mov     ss,ax
        mov     eax,0x0000ffff  ; 64K
        mov     esp,eax         ; initialize the stack pointer

        ;;
        bits    32
        ;;
        db      0xea            ; jump instruction (with setting cs)
        dw      .next2
        dw      0x08            ; cs := 0x08
.next2:
        ;; jump to boot2.c
        jmp dword 0x8200

;;; interrupt handler IRQ1 (keyboard)
.handler_irq1:
        push    es
        push    ds
        pushad
        mov     eax,esp
        push    eax
        mov     ax,ss
        mov     ds,ax
        mov     es,ax

        ;;  read a function pointer at 0x7e00 and call it.
        mov     ebx,0x7e00
        mov     edx,[ebx]
        cmp     edx,0
        je      .handler_irq1_skip
        call    edx

.handler_irq1_skip:
        pop     eax
        popad
        pop     ds
        pop     es
        iretd

;;; messages
press_key:
        db      "Press any key to boot...", 0x00
read_err:
        db      "FDD error", 0x00

;;; GDT (Global Descriptor Table) entries
gdt_data:
        ;; segment 0x00
        db      0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00
        ;; segment 0x08
        ;; limit 0xfffff, base 0x0000, access 0x409a (32bit, privilege, code)
        db      0xff,0xff,0x00,0x00, 0x00,0x9a,0x4f,0x00
        ;; segment 0x10
        ;; limit 0xfffff, base 0x0000, access 0x4092 (32bit, privilege, data)
        db      0xff,0xff,0x00,0x00, 0x00,0x92,0x4f,0x00

gdt_ptr:
        dw      0x0017          ; limit
        dw      gdt_data        ; lower 16 bits of the GDT address
        dw      0x0000          ; higher 16 bits

;;; IDT (Interrupt Descriptor Table)
;;; The entries are at 0x90000.
idt_ptr:
        dw      0x07ff          ; limit
	dw      0x0000          ; lower 16 bits of the IDT address
        dw      0x0009          ; higher 16 bits

;;; this is a boot sector.
        times   510-($-$$) DB 0
        dw      0xaa55          ; magic number
