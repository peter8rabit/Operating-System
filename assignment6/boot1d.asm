;;;  Initial boot loader
;;;
;;;  Memory map:
;;;
;;;  07c00..     : initial boot loader
;;;  07e00..07eff: interrupt handler table
;;;  07f00..     : TSS
;;;  08000..0a3ff: boot2 (boot.obj)
;;;       ..0ffff: stack area
;;;  80000..801ff: DMA buffer for FDC
;;;  90000..90800: IDT
;;;

IDT_ADDR        equ 0x90000      ; IDT address
IDT_SIZE        equ 0x800        ; IDT size
HANDLERS_TBL    equ 0x07e00      ; the list of handlers
TSS_DATA        equ 0x07f00      ; TSS data structure (104 bytes)
BOOT2           equ 0x08000      ; the address of boot2
BOOT2U          equ 0x00800      ; BOOT2 >> 8
STACK_POINTER   equ 0x0ffff      ; 64K

        org     0x7c00
        jmp     start

        db      "Titech  "      ; OEM name (8 bytes)
        dw      512             ; sector size
        db      1               ; sector per cluster
        dw      1               ; FAT position
        db      2               ; # of FATs
        dw      224             ; # of entries of the root directory
        dw      2880            ; # of sectors
        db      0xf0            ; media type (1.44MB FD)
        dw      9               ; FAT size (sectors)
        dw      18              ; sector per cylinder
        dw      2               ; # of heads
        dd      0
        dd      2880            ; # of sectors
        db      0,0,0x29
        dd      0xffffffff      ; volume serial number
        db      "BOOT_DISK  "	; volume label (11 bytes)
        db      "FAT12   "      ; file system name (8 bytes)

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
;;; dh: head (0 or 1)
;;; ch: cyliner (0..)
read_cylinder:
        mov     es,ax           ; destination address = [es:bx]
        mov     bx,0
        mov     dl,0            ; drive 0 
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

        mov     ax,BOOT2U       ; address
        mov     ch,1            ; cylinder 1
        mov     dh,0            ; head 0
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

        ;; initialize GDT, TR, and IDT
        mov     bx,gdt_ptr
        lgdt    [bx]                   ; set GDT
        mov     dword edx,IDT_ADDR     ; IDT 0x90000..0x907ff
.loop1:
        mov     dword [edx], 0
        mov     dword [edx+4], 0
	add     dword edx,8
        cmp     edx,IDT_ADDR+IDT_SIZE
        jne     .loop1

        mov     bx,idt_ptr
        lidt    [bx]            ; set IDT

        ;; initialize PIC (Programmable Interrupt Controller)
        mov     al,0x11
        out     0x20,al         ; PIC0 ICW1
	mov     al,0x20
        out     0x21,al         ; PIC0 ICW2: IRQ0-7 causes INT 0x20-27
	mov     al,0x04
        out     0x21,al         ; PIC0 ICW3
	mov     al,0x01
        out     0x21,al         ; PIC0 ICW4

	mov     al,0x11
        out     0xa0,al         ; PIC1 ICW1
	mov     al,0x28
        out     0xa1,al         ; PIC1 ICW2: IRQ8-15 causes INT 0x28-2f
	mov     al,0x02
        out     0xa1,al         ; PIC1 ICW3
	mov     al,0x01
        out     0xa1,al         ; PIC1 ICW4

        mov     al,0xfb
        out     0x21,al         ; PIC0 IMR (disable all interrupts except PIC1)
	mov     al,0xff
        out     0xa1,al         ; PIC1 IMR (disable all interrupts)

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
        mov     eax,STACK_POINTER
        mov     esp,eax         ; initialize the stack pointer

        ;;
        bits    32
        ;;
        db      0xea            ; jump instruction (with setting cs)
        dw      .next2
        dw      0x08            ; cs := 0x08
.next2:
        ;; jump to boot2
        jmp dword BOOT2

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
        ;; limit 0xfffff, base 0x0000, access 0x4f9a (32bit, privilege, code)
        db      0xff,0xff,0x00,0x00, 0x00,0x9a,0x4f,0x00
        ;; segment 0x10
        ;; limit 0xfffff, base 0x0000, access 0x4f92 (32bit, privilege, data)
        db      0xff,0xff,0x00,0x00, 0x00,0x92,0x4f,0x00
        ;; segment 0x18
        ;; limit 0xfffff, base 0x0000, access 0x4ffa (32bit, user, code)
        db      0xff,0xff,0x00,0x00, 0x00,0xfa,0x4f,0x00
        ;; segment 0x20
        ;; limit 0xfffff, base 0x0000, access 0x4ff2 (32bit, user, data)
        db      0xff,0xff,0x00,0x00, 0x00,0xf2,0x4f,0x00
        ;; segment 0x28 (TSS)
        ;; limit 103, base TSS_DATA, access 0x0089
        db      103,0x00
        dw      TSS_DATA
        db      0x00,0x89,0x00,0x00

gdt_ptr:
        dw      0x002f          ; limit
        dw      gdt_data        ; lower 16 bits of the GDT address
        dw      0x0000          ; higher 16 bits

;;; IDT (Interrupt Descriptor Table)
idt_ptr:
        dw      0x07ff          ; limit
        dd      IDT_ADDR        ; the IDT address

;;; this is a boot sector.
        times   510-($-$$) db 0
        dw      0xaa55          ; magic number
;;; the end of the first sector

;;; the sectors for FAT etc.
        db      0xf0,0xff,0xff  ; FAT 1 (9 sectors)
        db      0,0,0,          0xff,0x6f,0x00, 0x07,0x80,0x00
        db      0x09,0xa0,0x00, 0x0b,0xc0,0x00, 0x0d,0xe0,0x00
        db      0x0f,0x00,0x01, 0x11,0x20,0x01, 0x13,0x40,0x01
        db      0x15,0x60,0x01, 0xff,0x0f
        times   512*9-3-32 db 0

        db      0xf0,0xff,0xff  ; FAT 2 (9 sectors)
        db      0,0,0,          0xff,0x6f,0x00, 0x07,0x80,0x00
        db      0x09,0xa0,0x00, 0x0b,0xc0,0x00, 0x0d,0xe0,0x00
        db      0x0f,0x00,0x01, 0x11,0x20,0x01, 0x13,0x40,0x01
        db      0x15,0x60,0x01, 0xff,0x0f
        times   512*9-3-32 db 0

	;;  root directory (14 sectors)
	db      "BOOT    "
        db      "OBJ"
        db      0x20, 0, 0, 0, 0
        dw      0, 0x399a, 0x396b, 0x40, 0x396a, 5
        dd      512*18          ; file size

        db      "TEST    "
        db      "TXT"
        db      0x20, 0, 0, 0, 0
        dw      0, 0x399a, 0x396b, 0x40, 0x396a, 4
        dd      512             ; file size

        times   512*14-32*2 db 0
        ;; gap
        ;; the 3rd sector is used by TEST.TXT
        times   512*3 db 0
        ;; other files are stored at cyliner 1 or later (at sector 36..)
