; decifra.asm
global _start
section .text

_start:
	MOV edx,len
	MOV ecx,cadena
	MOV ebx,1
	MOV eax,7
	INT 0x80
bucle:
	CMP BYTE[ecx],0x00
	JNE decifra
	JMP fin
decifra:

	MOV al,BYTE[ecx]
	MOV ah,BYTE[ecx]

	ROL BYTE[ecx],2		;ROL de 3
	OR ah,al
	NOT BYTE[ecx]
	XOR BYTE[ecx],8
	MOV BYTE[ecx],ah
	SHR al,3

	MOV ebx,1		;muestra byte actual
	MOV edx,1
	MOV eax,4
	INT 0x80
	INC ecx
	JMP bucle		;regresa a bucle:
fin:
	MOV eax,1
	MOV ebx,0
	INT 0x80

section .data

	cadena db "/!'=", 0xa
	len equ $ - cadena
