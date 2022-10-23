TITLE NOME:VICTOR DE MELO ROSTON | RA:22006737

.MODEL SMALL

.DATA
    MSG1 db  10, 13, 'Digite o 1o numero: ','$'  ;DEFININDO AS MENSAGENS    
    MSG2 db  10, 13, 'Digite o 2o numero: ','$'
    MSG3 db  10, 13, 'RESULTADO: ','$'
    MSG4 db  10, 13, 'CONTAS ARITIMETICAS','$'
    MSG5 db  10, 13, 'ESCOLHA A OPERACAO A SER REALIZADA','$'
    MSG6 db  10, 13, '1-SOMA','$'
    MSG7 db  10, 13, '2-SUBTRACAO','$'
    MSG8 db  10, 13, '3-MULTIPLICACAO','$'
    MSG9 db  10, 13, '4-DIVISAO','$'
    MSG10 db  10, 13, '->','$'
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

;COR DE FUNDO
    MOV AH,00
    MOV AL,03h
    INT 10H

    MOV AH,09
    MOV AL,20H
    MOV BH,00
    MOV BL,1FH
    MOV CX,800H
    INT 10H

;SELECIONA A OPERACAO
    LEA DX, MSG5
    MOV AH,09H          ; IMPRIME MSG5
    INT 21H

    LEA DX, PULA_LINHA
    MOV AH,09H          ;PULA LINHA
    INT 21H

    LEA DX, MSG6
    MOV AH,09H          ; IMPRIME MSG6
    INT 21H

    LEA DX, MSG7
    MOV AH,09H          ; IMPRIME MSG7
    INT 21H

    LEA DX, MSG8
    MOV AH,09H          ; IMPRIME MSG8
    INT 21H

    LEA DX, MSG9
    MOV AH,09H          ; IMPRIME MSG9
    INT 21H

    LEA DX, PULA_LINHA
    MOV AH,09H          ; PULA LINHA
    INT 21H

    LEA DX, MSG10
    MOV AH,09H          ; IMPRIME MSG10
    INT 21H

    ;MOV AH,01H         ; ENTRADA DE 1 A 4 PARA ESCOLHER QUAL OPERACAO FAZER
    ;INT 21H



    JMP ADICAO

ADICAO:
    CALL INPUT

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
    CALL INPUT

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
    CALL INPUT

    XOR DX, DX          ; ZERA BX PARA ARMAZENAR RESULTADOS
    MOV CX, 4           ; O LOOP SERA FEITO 4 VEZES POIS O RESULTADO PODE DAR ATE 4 BITS

    MOV BL,NUM1         ; NUMERO QUE SERA ADICIONADO NO RESULTADO E ROTACIONADO A ESQUERDA A CADA REPETICAO
    MOV BH,NUM2         ; NUMERO QUE VAI SER A QUANTIDADE DE VEZES QUE O NUM1 VAI SER ADICIONADO, 
                        ;  SENDO ESSE NUM2 BINARIO QUE MANDARA UM VALOR PARA A CF, E CASO 0 PULA 
                        ;  A SOMA DO NUM1 NO RESULTADO E CASO 1 ADICIONA O NUM1 AO RESULTADO

VOLTA:
    SHR BH,1            ; MOVIMENTA NUM2 P/ CF (CASO 1 ADICIONA BL AO RESULTADO E DESLOCA O NUM1 
    JNC PULA            ;  PARA ESQUERDA PARA A PROXIMA SOMA, CASO 0 APENAS DESLOCA NUM1 PARA ESQUERDA)
    ADD DL,BL

PULA:
    SHL BL,1            ; PARA A PROXIMA SOMA E PRECISO PULAR UMA CASA A ESQUERDA
    LOOP VOLTA

    MOV RESULTADO,DL    ; PASSA O VALOR FINA DA MULTIPLICACAO PARA A VARIAVEL RESULTADO

    LEA DX, MSG3
    MOV AH, 09H         ; PRINT O MSG3 NA TELA
    INT 21H

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    MOV AH, 4CH         ; ENCERRA O PROGRAMA!   
    INT 21H


MAIN ENDP


;ENTRADA DE DOIS NUMEROS
INPUT PROC

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

    RET

INPUT ENDP


OUTPUT PROC
    xor ax, ax          ; ZERA O CONTEÚDO DE AX
    MOV AL, RESULTADO   ; PASSA O RESULTADO PRA AL
    MOV BL, 10          ; ATRIBUI 10 PRA BL
    DIV BL              ; DIVIDI O AL POR 10 - (AL)/10 - AGORA O RESULTADO DA DIVISÃO ESTÁ EM AL
                        ;  E O RESTO DA DIVISÃO ESTÁ EM AH
    MOV BX,AX           ; PASSA ESSE RESULTADOS PARA BX

    MOV DL, BL          
    ADD DL, 30H         ; IMPRIME O QUE ESTÁVA EM AL ANTERIORMENTE 
    MOV AH, 02H
    INT 21H
    
    MOV DL, BH
    ADD DL, 30H         ; IMPRIME O QUE ESTÁVA EM AH ANTERIORMENTE 
    MOV AH, 02H
    INT 21H

    RET                 ; RETORNA DA FUNÇÃO

OUTPUT ENDP

; OBS: SE VOCÊ TEM UM NÚMERO MAIOR DO QUE NOVE, ELE É DE VÁRIOS ALGARISMOS, EX: 1547 = 1000 + 500 + 40 + 7. 
; BASTA DIVIDIR POR 1000, DEPOIS POR 100, POR 10 E IR IMPRIMINDO O RESULTADO DA DIVISÃO E ARMAZENADO O RESTO QUE FALTA 
; 1547 / 1000 = 1 (PRINTAR ESSE 1) E 1547 % 1000 = 547 (ARMAZENE ESTA VALOR)
; 547 / 100 = 5 (PRINTAR ESSE 5) E 547 % 100 = 47 (ARMAZENE ESTA VALOR)
; 47 / 10 = 4 (PRINTAR ESSE 4) E 47 % 10 = 7 (ARMAZENE ESTA VALOR)
; POR FIM BASTA PRINTAR O 7!


END MAIN