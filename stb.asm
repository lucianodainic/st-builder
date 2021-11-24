.model small   ; memory model type
.stack 100h
.data
	a dw 0    	;column
	b1 dw 0		;row
	b2 dw 0    	;row
	l db 29    	;triangle base length divided by 2
	x db 15		;square length
.code
	mov ax,	@data   ;data segment initialization
	mov ds,	ax
	;set graphics video mode
	mov ah,	0
	mov al,	13h
	int 10h

   	mov ah,	0h	;get a key and store in al
    int 16h

	check_s: 
		cmp al,	's'          
        je e_square
		jne check_t
	check_t: 
		cmp al,	't'
		je e_triangle
		jne other_keys
	e_square: 
		mov al,	15
		mov	a,	5    
		mov b1,	5	
		mov b2,	33
		call square
		jmp s_pos_key
	e_triangle: 
		mov al,	12
		mov	a,	20   
		mov b1,	5	
		call triangle
		jmp t_pos_key
	;for the square
	s_pos_key: 
		mov ah,	0h			;get an arrow key 
	    int 16h
		cmp ax,	4D00h 		;right arrow
	    je s_right
		jne s_l_key
	s_l_key: 
		cmp ax,	4B00h 		;left arrow
	    je s_left
		jne s_up_key
	s_up_key: 
		cmp ax,	4800h 		;up arrow
	    je s_up
		jne s_d_key
	s_d_key: 
		cmp ax,	5000h		;down arrow 
	    je s_down
		jne check_s
	other_keys: 
		jmp exit
	i_shape: 
		jmp check_s
	s_right: 
		mov al, 0
		call square
		inc a
		mov al, 15
		call square
		jmp s_pos_key
	s_left:	
		mov al,	0
		call square
		dec a
		mov al, 15
		call square
		jmp s_pos_key
	s_up: 
		mov al, 0
		call square
		dec b1
		dec b2
		mov al, 15
		call square
		jmp s_pos_key
	s_down:	
		mov al, 0
		call square
		inc b1
		inc b2
		mov al, 15
		call square
		jmp s_pos_key
	;for the triangle
	t_pos_key:
		mov ah, 0h			;get an arrow key 
	    int 16h
		cmp ax, 4D00h        ;right arrow
	    je t_right
		jne t_l_key
	t_l_key:  
		cmp ax, 4B00h 		;left arrow
	    je t_left
		jne t_up_key
	t_up_key: 
		cmp ax, 4800h 		;up arrow
	    je t_up
		jne t_d_key
	t_d_key:
		cmp ax, 5000h 		;down arrow
	    je t_down
		jne i_shape
	t_right:
		mov al, 0
		call triangle
		inc a
		mov al, 12
		call triangle
		jmp t_pos_key
	t_left:	
		mov al, 0
		call triangle
		dec a
		mov al, 12
		call triangle
		jmp t_pos_key
	t_up:   
		mov al, 0
		call triangle
		dec b1
		dec b2
		mov al, 12
		call triangle
		jmp t_pos_key
	t_down:	
		mov al, 0
		call triangle
		inc b1
		inc b2
		mov al, 12
		call triangle
		jmp t_pos_key
	exit: 
		;set text mode
		mov ah, 0h
		mov al, 3h
		int 10h

	mov ah, 4ch
	int 21h

	;***************************
	square PROC
		mov dx, b1
		mov cx, a
		mov bl, l			
		mov ah, 0ch
		sq_1: 
			int 10h 			;light coord(b1,a)
			push dx
			mov dx, b2		
			int 10h				;light coord(b2,a)
			pop dx
			inc cx
			dec bl
			jnz sq_1
			mov bl,l
		sq_2: 
			int 10h 		;light coord(b1,a)
			push cx
			mov cx, a
			int 10h
			pop cx
			inc dx
			dec bl
			jnz sq_2
		ret
	ENDP

	triangle PROC
		mov dx, b1
		mov cx, a
		mov bl, x			
		mov ah, 0ch
		tr_1: 
			int 10h
			inc cx
			inc dx
			dec bl
			jnz tr_1		
			mov dx, b1
			mov cx, a
			mov bl, x			
			mov ah, 0ch
		tr_2: 
			int 10h
			dec cx
			inc dx
			dec bl
			jnz tr_2
			add x,15
			mov bl, x
		tr_3:
			inc cx 
			int 10h
			dec bl
			jnz tr_3
			mov x,15
		ret
	ENDP
end