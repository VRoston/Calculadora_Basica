TITLE NOME:VICTOR DE MELO ROSTON | RA:22006737

.MODEL SMALL

.DATA
    MSG1 db  10, 13, 'Digite o 1o numero: ','$'  ;DEFININDO AS MENSAGENS    
    MSG2 db  10, 13, 'Digite o 2o numero: ','$'
    MSG3 db  10, 13, 'RESULTADO: ','$'
    MSG4 db  10, 13, 'QUAL OPERACAO:(1-SOMA)(2-SUBTRACAO)(3-MULTIPLICACAO)(4-DIVISAO)','$'
    PULA_LINHA db 10, 13, '$'
    
    AUXILIAR DB ?

    NUM1 DB ?                                    ;DEFININDO ESPACO PARA ARMAZENAR OS NUMEROS
    NUM2 DB ?
    RESULTADO DB ?

.CODE
MAIN PROC
    MOV AX,@DATA        
    MOV DS,AX           ;ININICIALIZA O DATA
    MOV ES,AX

    LEA DX, MSG1
    MOV AH, 09H         ; PRINT O MSG1 NA TELA
    INT 21H

    MOV AH,01H
    INT 21H             ; FAZ A ENTRADA DO PRIMEIRO NÚMERO
    SUB AL,30H          ; PASSA O CARACTER PARA NUMERO
    MOV NUM1, AL        ; ARMAZENA O NUMERO EM "NUM1"

    LEA DX, MSG2
    MOV AH, 09H         ; PRINT O MSG2 NA TELA
    INT 21H

    MOV AH,01H
    INT 21H             ; FAZ A ENTRADA DO SEGUNDO NÚMERO
    SUB AL,30H          ; PASSA O CARACTER PARA NUMERO
    MOV NUM2, AL        ; ARMAZENA O NUMERO EM "NUM2"

    JMP MULTIPLICACAO

ADICAO:
    MOV DL, NUM1        
    ADD DL, NUM2        ; FAZ A SOMA DOS NUMERO E ARMAZENA EM "RESULTADO"
    MOV RESULTADO, DL

    LEA DX, MSG3
    MOV AH, 09H         ; PRINT O MSG3 NA TELA
    INT 21H

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    MOV AH, 4CH         ; ENCERRA O PROGRAMA!
    INT 21H


SUBTRACAO:
    MOV DL, NUM1        
    SUB DL, NUM2        ; FAZ A SUBTRACAO DOS NUMERO E ARMAZENA EM "RESULTADO"
    MOV RESULTADO, DL

    LEA DX, MSG3
    MOV AH, 09H         ; PRINT O MSG3 NA TELA
    INT 21H

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    MOV AH, 4CH         ; ENCERRA O PROGRAMA!
    INT 21H


MULTIPLICACAO:
;MULTIPLICACAO
    XOR DX, DX          ;ZERA BX PARA ARMAZENAR RESULTADOS
    MOV CX, 4           ;ENTRADA PARA REPITIR O LOOP 4 VEZES, CONTA COM 2 BITS

    MOV BH,NUM2         ;MULTIPLICANDO VAI SER UM AUXILIAR PARA MULTIPLICAR
    MOV BL,NUM1

VOLTA:
    SHR BH,1            ;MOVIMENTA NUM2 P/ DIREITA
    JNC PULA            ;SE O BIT DA DIREITA EM BH FOR 0 PULA, CASO 1, ADICIONA NUM1 NA VARIAVEL DA RESPOSTA
    ADD DL,BL

PULA:
    SHL BL,1            ;PARA A PROXIMA SOMA E PRECISO PULAR UMA CASA A ESQUERDA
    LOOP VOLTA
    MOV RESULTADO,DL    ;ARMAZENA O VALOR DE BL EM RESULTADO PARA ENVIAR PARA OUTPUT

;IMPRIMIR RESULTADO
    LEA DX, MSG3
    MOV AH, 09H         ; PRINT O MSG3 NA TELA
    INT 21H

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    MOV AH, 4CH         ; ENCERRA O PROGRAMA!   
    INT 21H
MAIN ENDP



OUTPUT PROC
    xor ax, ax          ;ZERA O CONTEÚDO DE AX
    MOV AL, RESULTADO   ;PASSA O RESULTADO PRA AL
    MOV BL, 10          ;ATRIBUI 10 PRA BL
    DIV BL              ;DIVIDI O AL POR 10 - (AL)/10 - AGORA O RESULTADO DA DIVISÃO ESTÁ EM AL
                        ; E O RESTO DA DIVISÃO ESTÁ EM AH
    MOV BX,AX           ;PASSA ESSE RESULTADOS PARA BX

    MOV DL, BL          
    ADD DL, 30H         ;IMPRIME O QUE ESTÁVA EM AL ANTERIORMENTE 
    MOV AH, 02H
    INT 21H
    
    MOV DL, BH
    ADD DL, 30H         ;IMPRIME O QUE ESTÁVA EM AH ANTERIORMENTE 
    MOV AH, 02H
    INT 21H

    RET                 ;RETORNA DA FUNÇÃO

OUTPUT ENDP

; OBS: SE VOCÊ TEM UM NÚMERO MAIOR DO QUE NOVE, ELE É DE VÁRIOS ALGARISMOS, EX: 1547 = 1000 + 500 + 40 + 7. 
; BASTA DIVIDIR POR 1000, DEPOIS POR 100, POR 10 E IR IMPRIMINDO O RESULTADO DA DIVISÃO E ARMAZENADO O RESTO QUE FALTA 
; 1547 / 1000 = 1 (PRINTAR ESSE 1) E 1547 % 1000 = 547 (ARMAZENE ESTA VALOR)
; 547 / 100 = 5 (PRINTAR ESSE 5) E 547 % 100 = 47 (ARMAZENE ESTA VALOR)
; 47 / 10 = 4 (PRINTAR ESSE 4) E 47 % 10 = 7 (ARMAZENE ESTA VALOR)
; POR FIM BASTA PRINTAR O 7!


END MAIN