; naskfunc
; TAB=4

[FORMAT "WCOFF"]				; 制作目标文件的模式
[INSTRSET "i486p"]				; 使用到486为止的指令
[BITS 32]						; 制作32位模式用的机器语言
[FILE "naskfunc.nas"]			; 文件名

		GLOBAL _io_hlt, _io_cli, io_sti, _io_stihlt
		GLOBAL _io_in8, _io_in16, _io_in32
		GLOBAL _io_out8,_io_out16,_io_out32
		GLOBAL _io_load_eflags, _io_store_eflags
		GLOBAL _load_gdtr, _load_idtr

[SECTION .text]

_io_hlt:	; void io_hlt(void);
		HLT
		RET

_io_cli:
		CLI
		RET

 io_sti:
 		STI
		RET

_io_stihlt:
		STI
		HLT
		RET

_io_in8:
		MOV		EDX,[ESP+4]
		MOV		EAX,0
		IN 		AL,DX
		RET

_io_in16:	; int io_in16(int port);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,0
		IN		AX,DX
		RET

_io_in32:	; int io_in32(int port);
		MOV		EDX,[ESP+4]		; port
		IN		EAX,DX
		RET

_io_out8:	; void io_out8(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		AL,[ESP+8]		; data
		OUT		DX,AL
		RET

_io_out16:	; void io_out16(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,[ESP+8]		; data
		OUT		DX,AX
		RET

_io_out32:	; void io_out32(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,[ESP+8]		; data
		OUT		DX,EAX
		RET

_io_load_eflags:
		PUSHFD
		POP		EAX
		RET

_io_store_eflags:
		MOV 	EAX,[ESP+4]
		PUSH 	EAX
		POPFD
		RET

_load_gdtr:
		MOV 	AX,[ESP+4]
		MOV		[ESP+6],AX
		LGDT 	[ESP+6]
		RET

_load_idtr:
		MOV 	AX,[ESP+4]
		MOV		[ESP+6],AX
		LIDT 	[ESP+6]
		RET