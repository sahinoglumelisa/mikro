my_ds 		SEGMENT PARA 'data'
sayilar		db 10 dup(1)
aralik 		db 0
mod_sayi	DB ?
aralik2 	db 0
CR		EQU 13
LF		EQU 10
HATA		DB CR, LF, 'Dikkat !!! Sayi vermediniz yeniden giris yapiniz.!!!  ', 0
n		DB 5 
message1    	DB 'Dizi buyuklugu icin sayi giriniz (max 10):$', 0  
message2    	DB 'Sayi girin(0 ile 255 arasinda):$', 0  
my_ds 		ENDS

my_ss		SEGMENT PARA STACK 'yigin'
		DW 20 DUP(1)
my_ss		ENDS

my_cs 		SEGMENT PARA 'kod'
		ASSUME CS:my_cs, DS:my_ds, SS:my_ss 

GIRIS_DIZI 	MACRO 
		LOCAL GETN_START, NEW, NEGATIVE, CTRL_NUM,ERROR, FIN_READ, FIN_GETN

		POP CX
		POP SI
makrodongu:
		MOV AH, 09h         	; DOS print string function
    		LEA DX, message2   	; mesaj2 adresi
    		INT 21h            	; DOS interrupt
    	        PUSH BX
       		PUSH CX
      		PUSH DX
GETN_START:
       		MOV DX, 1	                        ; sayının şimdilik + olduğunu varsayalım 
       		XOR BX, BX 	                        ; okuma yapmadı Hane 0 olur. 
       		XOR CX,CX	                        ; ara toplam değeri de 0’dır. 
NEW:
        	CALL GETC	                        ; klavyeden ilk değeri AL’ye oku. 
        	CMP AL,CR 
        	JE FIN_READ	                        ; Enter tuşuna basilmiş ise okuma biter
        	CMP  AL, '-'	                        ; AL ,'-' mi geldi ? 
        	JNE  CTRL_NUM	                        ; gelen 0-9 arasında bir sayı mı?
NEGATIVE:
        	MOV DX, -1	                        ; - basıldı ise sayı negatif, DX=-1 olur
        	JMP NEW		                        ; yeni haneyi al
CTRL_NUM:
        	CMP AL, '0'	                        ; sayının 0-9 arasında olduğunu kontrol et.
        	JB error 
        	CMP AL, '9'
        	JA error		                ; değil ise HATA mesajı verilecek
        	SUB AL,'0'	                        ; rakam alındı, haneyi toplama dâhil et 
        	MOV BL, AL	                        ; BL’ye okunan haneyi koy 
       		MOV AX, 10 	                        ; Haneyi eklerken *10 yapılacak 
        	PUSH DX		                        ; MUL komutu DX’i bozar işaret için saklanmalı
        	MUL CX		                        ; DX:AX = AX * CX
        	POP DX		                        ; işareti geri al 
        	MOV CX, AX	                        ; CX deki ara değer *10 yapıldı 
        	ADD CX, BX 	                        ; okunan haneyi ara değere ekle 
        	JMP NEW 		                ; klavyeden yeni basılan değeri al 
ERROR:
        	MOV AX, OFFSET HATA 
        	CALL PUT_STR	                        ; HATA mesajını göster 
        	JMP GETN_START                          ; o ana kadar okunanları unut yeniden sayı almaya başla 
FIN_READ:
       	 	MOV AX, CX	                        ; sonuç AX üzerinden dönecek 
        	CMP DX, 1	                        ; İşarete göre sayıyı ayarlamak lazım 
        	JE FIN_GETN
        	NEG AX		                        ; AX = -AX
FIN_GETN:
		MOV [SI], AL         	; diziye kaydet
    		INC SI               	; sonraki eleman icin si arttir
        	POP DX
        	POP CX
        	POP DX
    		LOOP makrodongu      	

ENDM





ANA		PROC FAR 

		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX, my_ds
		MOV DS, AX

		MOV AH, 09h             ; DOS print string function
         	LEA DX, message1        ; mesaj1 adresi
           	INT 21h                 ; DOS interrupt 

		CALL GETN  
		MOV n, Al
		
		LEA SI, sayilar         ; sayilarin adresi
		xor cx,cx		
    		MOV CL, n             	; n boyutunu c'ye aktar

		PUSH SI
		PUSH CX
 		GIRIS_DIZI		; SI VE CX kullanıyorum, makroya aktariyorum

		LEA SI, sayilar         ; si'ya tekrar adresi yaziyorum
		xor cx,cx
    		MOV CL, n             	; n boyutunu tekrar c'ye aktarıyorum
		MOV BX, 0               ; en çok tekrar eden değerin frekansını saklar

		PUSH BX
		PUSH SI
		PUSH CX

		CALL MOD_FONK		; SI ve CX kullanıyorum, fonksiyona atiriyorum

		XOR AX,AX
		MOV AL,mod_sayi
		CALL PUTN

		MOV AH, 4Ch      	; DOS function to exit program
		MOV AL, 0        	; Exit code 0 (success)
		INT 21h        	   	; Call DOS interrupt to exit
 		RETF
ANA		ENDP





MOD_FONK 	PROC
		PUSH BP			; ana'da pushladigim cx ve si'yi kullanmak icin bp kullaniyorum
		MOV BP, SP
		MOV CX, [BP+4] 
		MOV SI, [BP+6]
		MOV BX, [BP+8]

DONGU_MOD: 
		XOR AX,AX
           	MOV al, [SI]            ; şu anki elemanı AX'e al
           	MOV DX, 0               ; geçerli elemanın tekrar sayısını sıfırla
           	LEA DI, SAYILAR         ; dizinin başını DI'ye al
		push cx

		xor cx,cx
		mov cl, n
DONGU_SAY: 
		
           	CMP AL, [DI]            ; aynı değer mi kontrol et
           	JNE GEC                 ; Eğer farklıysa geç
           	INC DX                  ; Aynıysa tekrar sayısını artır
GEC:       	INC DI               	; Bir sonraki elemana geç
           	LOOP DONGU_SAY

           	CMP DX, BX
           	JBE SONRA               ; Eğer tekrar sayısı düşükse geç
           	MOV BX, DX              ; Yeni en yüksek tekrar sayısı
           	MOV mod_sayi, al        ; En çok tekrar eden değeri mod olarak sakla
SONRA:     	INC SI			; Bir sonraki elemana geç
		pop cx
           	LOOP DONGU_MOD
		MOV SP, BP
		POP BP
           	RET
MOD_FONK	ENDP

























GETC		PROC NEAR
        ;------------------------------------------------------------------------
        ; Klavyeden basılan karakteri AL yazmacına alır ve ekranda gösterir. 
        ; işlem sonucunda sadece AL etkilenir. 
        ;------------------------------------------------------------------------
        	MOV AH, 1h
        	INT 21H
        	RET 
GETC		ENDP 

PUT_STR		PROC NEAR
        ;------------------------------------------------------------------------
        ; AX de adresi verilen sonunda 0 olan dizgeyi karakter karakter yazdırır.
        ; BX dizgeye indis olarak kullanılır. Önceki değeri saklanmalıdır. 
        ;------------------------------------------------------------------------
		PUSH BX 
        	MOV BX,	AX			        ; Adresi BX’e al 
        	MOV AL, BYTE PTR [BX]	                ; AL’de ilk karakter var 
PUT_LOOP:   
        	CMP AL,0		
        	JE  PUT_FIN 			        ; 0 geldi ise dizge sona erdi demek
        	CALL PUTC 			        ; AL’deki karakteri ekrana yazar
        	INC BX 				        ; bir sonraki karaktere geç
        	MOV AL, BYTE PTR [BX]
        	JMP PUT_LOOP			        ; yazdırmaya devam 
PUT_FIN:
		POP BX
		RET 
PUT_STR		ENDP
PUTC		PROC NEAR
        ;------------------------------------------------------------------------
        ; AL yazmacındaki değeri ekranda gösterir. DL ve AH değişiyor. AX ve DX 
        ; yazmaçlarının değerleri korumak için PUSH/POP yapılır. 
        ;------------------------------------------------------------------------
        	PUSH AX
        	PUSH DX
       	 	MOV DL, AL
       	 	MOV AH,2
        	INT 21H
        	POP DX
        	POP AX
        	RET 
PUTC 		ENDP 
PUTN 	PROC NEAR
        ;------------------------------------------------------------------------
        ; AX de bulunan sayiyi onluk tabanda hane hane yazdırır. 
        ; CX: haneleri 10’a bölerek bulacağız, CX=10 olacak
        ; DX: 32 bölmede işleme dâhil olacak. Soncu etkilemesin diye 0 olmalı 
        ;------------------------------------------------------------------------
        PUSH CX
        PUSH DX 	
        XOR DX,	DX 	                        ; DX 32 bit bölmede soncu etkilemesin diye 0 olmalı 
        PUSH DX		                        ; haneleri ASCII karakter olarak yığında saklayacağız.
                                                ; Kaç haneyi alacağımızı bilmediğimiz için yığına 0 
                                                ; değeri koyup onu alana kadar devam edelim.
        MOV CX, 10	                        ; CX = 10
        CMP AX, 0
        JGE CALC_DIGITS	
        NEG AX 		                        ; sayı negatif ise AX pozitif yapılır. 
        PUSH AX		                        ; AX sakla 
        MOV AL, '-'	                        ; işareti ekrana yazdır. 
        CALL PUTC
        POP AX		                        ; AX’i geri al 
        
CALC_DIGITS:
        DIV CX  		                ; DX:AX = AX/CX  AX = bölüm DX = kalan 
        ADD DX, '0'	                        ; kalan değerini ASCII olarak bul 
        PUSH DX		                        ; yığına sakla 
        XOR DX,DX	                        ; DX = 0
        CMP AX, 0	                        ; bölen 0 kaldı ise sayının işlenmesi bitti demek
        JNE CALC_DIGITS	                        ; işlemi tekrarla 
        
DISP_LOOP:
                                                ; yazılacak tüm haneler yığında. En anlamlı hane üstte 
                                                ; en az anlamlı hane en alta ve onu altında da 
                                                ; sona vardığımızı anlamak için konan 0 değeri var. 
        POP AX		                        ; sırayla değerleri yığından alalım
        CMP AX, 0 	                        ; AX=0 olursa sona geldik demek 
        JE END_DISP_LOOP 
        CALL PUTC 	                        ; AL deki ASCII değeri yaz
        JMP DISP_LOOP                           ; işleme devam
        
END_DISP_LOOP:
        POP DX 
        POP CX
        RET
PUTN 	ENDP 
GETN 	PROC NEAR
        ;------------------------------------------------------------------------
        ; Klavyeden basılan sayiyi okur, sonucu AX yazmacı üzerinden dondurur. 
        ; DX: sayının işaretli olup/olmadığını belirler. 1 (+), -1 (-) demek 
        ; BL: hane bilgisini tutar 
        ; CX: okunan sayının islenmesi sırasındaki ara değeri tutar. 
        ; AL: klavyeden okunan karakteri tutar (ASCII)
        ; AX zaten dönüş değeri olarak değişmek durumundadır. Ancak diğer 
        ; yazmaçların önceki değerleri korunmalıdır. 
        ;------------------------------------------------------------------------
        PUSH BX
        PUSH CX
        PUSH DX
GETN_START:
        MOV DX, 1	                        ; sayının şimdilik + olduğunu varsayalım 
        XOR BX, BX 	                        ; okuma yapmadı Hane 0 olur. 
        XOR CX,CX	                        ; ara toplam değeri de 0’dır. 
NEW:
        CALL GETC	                        ; klavyeden ilk değeri AL’ye oku. 
        CMP AL,CR 
        JE FIN_READ	                        ; Enter tuşuna basilmiş ise okuma biter
        CMP  AL, '-'	                        ; AL ,'-' mi geldi ? 
        JNE  CTRL_NUM	                        ; gelen 0-9 arasında bir sayı mı?
NEGATIVE:
        MOV DX, -1	                        ; - basıldı ise sayı negatif, DX=-1 olur
        JMP NEW		                        ; yeni haneyi al
CTRL_NUM:
        CMP AL, '0'	                        ; sayının 0-9 arasında olduğunu kontrol et.
        JB error 
        CMP AL, '9'
        JA error		                ; değil ise HATA mesajı verilecek
        SUB AL,'0'	                        ; rakam alındı, haneyi toplama dâhil et 
        MOV BL, AL	                        ; BL’ye okunan haneyi koy 
        MOV AX, 10 	                        ; Haneyi eklerken *10 yapılacak 
        PUSH DX		                        ; MUL komutu DX’i bozar işaret için saklanmalı
        MUL CX		                        ; DX:AX = AX * CX
        POP DX		                        ; işareti geri al 
        MOV CX, AX	                        ; CX deki ara değer *10 yapıldı 
        ADD CX, BX 	                        ; okunan haneyi ara değere ekle 
        JMP NEW 		                ; klavyeden yeni basılan değeri al 
ERROR:
        MOV AX, OFFSET HATA 
        CALL PUT_STR	                        ; HATA mesajını göster 
        JMP GETN_START                          ; o ana kadar okunanları unut yeniden sayı almaya başla 
FIN_READ:
        MOV AX, CX	                        ; sonuç AX üzerinden dönecek 
        CMP DX, 1	                        ; İşarete göre sayıyı ayarlamak lazım 
        JE FIN_GETN
        NEG AX		                        ; AX = -AX
FIN_GETN:
        POP DX
        POP CX
        POP DX
        RET 
GETN 	ENDP 



my_cs		ENDS
		END ANA