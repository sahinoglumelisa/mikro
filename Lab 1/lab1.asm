my_ds		SEGMENT PARA 'data'
vize		Dw 77,85,64,96
final		dw 56,63,86,74
n		Dw 4
obp        	Dw 4 DUP(3)							 
my_ds		ENDS

my_ss		SEGMENT PARA STACK 'yigin'
		DW 20 DUP(1)
my_ss		ENDS

my_cs		SEGMENT PARA 'kod'							 
		ASSUME CS:my_cs, DS:my_ds, SS:my_ss ; 

ANA		PROC FAR 
		PUSH DS
		XOR AX, AX
		PUSH AX 								
		MOV AX, my_ds
		MOV DS, AX
		MOV CX, n 		; ogrenci sayisini cx e atadim 
		LEA SI, vize
		LEA DI, final 								
		LEA BX, obp

DONGU:		MOV AX,[SI] 		; axte su an vize notu var 
		MOV DX, 4 
		MUL DX 			; vize notunu 4 ile carpiyorum
		MOV [BX], AX		; carpilmis vize notunu obpnin elemani yapiyorum	
		MOV AX, [DI]  		; axte final notu var
		MOV DX,6 
		MUL DX 			; final notunu 6 ile carpiyorum
		ADD [BX], AX		; vize*4 ve final*6yi toplayip eleman olarak birakiyorum
		MOV AX, [BX]							
		MOV DL ,10 
		DIV DL			; daha sonra 10a bolerek obpyi elde ediyorum
		CMP AH, 5   		; kalan 5ten buyukse bir yukari yuvarlamak istiyorum     
		JL  YUVARLAMA		; kalan 5ten kucukse yuvarlamama gerek yok
		INC AX				
					
YUVARLAMA: 	MOV [BX], AH   
		MOV [BX+1], AL        	; son yuvarlanmis/yuvarlanmamis hali
		ADD SI, 2            
         	ADD DI, 2            
         	ADD BX , 2              ; adresleri word oldugu icin 2 ile artiriyorum
         	LOOP DONGU     		
		
SORT:	  	MOV CX, n    
		DEC CX      
  	
DIS_DONGU:	PUSH CX       
                LEA SI, obp                     
          	MOV CX, n
		DEC CX                                       

IC_DONGU:	MOV AX, [SI]            ; ax simdiki eleman
           	MOV DX, [SI + 2]        ; dx sonraki eleman
            	CMP AX, DX
            	JAE DUR			; ax buyukse 
            	XCHG AX, DX             ; ax ile dx degistir
            	MOV [SI], AX            ; si adresine axin degerini yaz
            	MOV [SI + 2], DX	; diger adrese dxin degerini yaz		

DUR:   		ADD SI, 2               ; ax buyuk degilse siradaki elemana gec
		LOOP IC_DONGU
                 
            	POP CX  
		LOOP DIS_DONGU
              
		RETF
ANA		ENDP

my_cs		ENDS
		END ANA