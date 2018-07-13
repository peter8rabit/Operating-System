;;; The rest of the boot loader

IDT_ADDR        equ 0x90000      ; IDT address
HANDLERS_TBL    equ 0x07e00      ; the list of handlers
KEYBD_HANDLER   equ 0x00
TIMER_HANDLER   equ 0x04
FDC_HANDLER     equ 0x08
GPE_HANDLER     equ 0x0c
SYS_HANDLER     equ 0x10

	bits 32

	global boot2
	extern _boot
boot2:
        mov     ebx,handler_int0d
        mov     edx,0x0d
        mov     eax,GPE_HANDLER
        call    register_handler

        mov     ebx,handler_irq0
        mov     edx,0x20
        mov     eax,TIMER_HANDLER
        call    register_handler

	mov     ebx,handler_irq1
        mov     edx,0x21
        mov     eax,KEYBD_HANDLER
        call    register_handler

      	mov     ebx,handler_irq6
        mov     edx,0x26
        mov     eax,FDC_HANDLER
        call    register_handler

      	mov     ebx,handler_int30
        mov     edx,0x30
        mov     eax,SYS_HANDLER
        call    register_handler
        mov     byte [edx+5],0xee       ; 0x8e | (ring << 5) for user mode

        jmp dword _boot

;;; ebx: handler address (higher 8bits should be 0)
;;; edx: INT number
;;; eax: handler position
register_handler:
        sal     edx,3                   ; << 3
        add     edx,IDT_ADDR
        mov     word [edx],bx
        mov     word [edx+2],8          ; segment selector
        mov     byte [edx+4],0          ; always 0
        mov     byte [edx+5],0x8e       ; 0x8e | (ring << 5)
        mov     word [edx+6],0          ; upper 16bits of handler_any
        mov     dword [eax+HANDLERS_TBL],0
        ret

        align 4
;;; interrupt handler INT 0x0d (general protected exception)
handler_int0d:
        add     esp,4           ; clean up the error code
        push    dword GPE_HANDLER
        jmp     handler_any

        align 4
;;; interrupt handler IRQ0 (timer)
handler_irq0:
        push    dword TIMER_HANDLER
        jmp     handler_any

        align 4
;;; interrupt handler IRQ1 (keyboard)
handler_irq1:
        push    dword KEYBD_HANDLER
        jmp     handler_any

        align 4
;;; interrupt handler IRQ6 (Floppy Disk)
handler_irq6:
        push    dword FDC_HANDLER
        jmp     handler_any

        align 4
;;; interrupt handler INT 0x30 (system call)
handler_int30:
	sti                     ; this is a system call
        push    dword SYS_HANDLER
        jmp     handler_any

        align 4
handler_any:
        push    es
        push    ds
        pushad                  ; 8 x 32bits
        mov     eax,esp
        push    eax             ; esp is a handler argument
        mov     ax,ss
        mov     ds,ax
        mov     es,ax

        ;;  read a function pointer and call it.
        mov     ebx,[esp+44]
        mov     edx,[ebx+HANDLERS_TBL]
        cmp     edx,0
        je      .handler_any_skip
        call    edx

.handler_any_skip:
        pop     eax
        popad
        pop     ds
        pop     es
        add     esp,4           ; cleans up the pushed handler position
        iretd

