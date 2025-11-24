myS		SEGMENT PARA 'my'
		ORG 100h
		ASSUME DS:myS, CS:myS, SS:myS

kaynak	PROC NEAR

		MOV CL, max
		dec cl;
		MOV DI, 0
		MOV SI,0 

dongu1:		PUSH CX 	; ilk dongu max-c kere donecek, cxi sakliyorum

		mov terminate,0
		MOV CL, C	; ikinci dongu c-1 kadar donecek
		dec cl
		mov al, 1	; Ayı tekrar 1 yapıyorum	
		mov A, al

dongu2:		
		mov al, A	; al icine A degerini aliyorum
		mov dl, al	; dl icine A degerini aliyorum
		mul dl		; a2 degerini buluyorum
		mov dx, ax 	; dx icine a2 yaziyorum

		mov al, C	; al icine C degerini aliyorum
		mov bl, al	; bl icine C degerini aliyorum
		mul bl		; c2 degerini buluyorum
		mov bx, ax 	; bx icine c2 yaziyorum

		sub ax,dx	; ax su an b2
		push cx		; dongu sayisini sakliyorum
		call sqrt
		pop cx		; dongu sayisini kurtariyorum
		mov al, terminate
    		cmp al, 1
		je endOuterLoop
		
 		inc A
		LOOP dongu2	;burada cx dusuyor benim c yi tutmam lazim

endOuterLoop:	inc C
		pop cx
		loop dongu1

		RET
kaynak	ENDP


sqrt		PROC NEAR

		mov bx, ax	; bxte su an b2 var
		mov cl, C
		mov al, A
		sub cl, al	; c-a kadar donecek
		mov sqrtA, al	; baslangic degeri A
				
sqrtdongu:	
		mov dl, sqrtA	
		mov al, dl
		mul dl		; a2 degerini buluyorum. ax su an a2
		
		cmp ax,bx	
		jne notequal
		
equal:		push cx
		call asalmi
		pop cx	
		je endLoop

notequal:	inc sqrtA	; denenecek degeri bir artiriyorum
		LOOP sqrtdongu	
endLoop:	RET
	
sqrt		ENDP



asalmi		PROC NEAR
 
		
		mov cl,2		; cxte i var, 2den basliyor
		xor ax,ax		
		mov al,C
		div cl
		mov dl,al		; dl de c/2 var
		mov bl, C

mantik:
		xor ax,ax
    		mov al, bl		; blde C var
    		div cl			; C/i bolunce a degisiyor dikkat
    
    		cmp ah, 0     		; kalan 0 ise asal degil. gerisine bakmaya gerek yok
   		je not_prime   

    		inc cx       		; kalan 0 degilse i(cx) yi arttir 
    		cmp cl, dl 		; i ile c/2'yi kiyasla
    		jl mantik

is_prime:
    		mov primeOddSum[DI], bl
    		inc DI
		mov terminate, 1
    		ret

not_prime:
    		mov nonPrimeOrEvenSum[SI], bl
    		inc SI   
		mov terminate, 1                  
    		ret

asalmi		ENDP



primeOddSum		DB 15 DUP(4)
nonPrimeOrEvenSum 	DB 15 DUP(3)
aralik 			db 4 dup(0)
A			DB 1
C			DB 2
sqrtA			DB ?
terminate 		db 0
max 			dB 50

myS		ENDS
		END kaynak