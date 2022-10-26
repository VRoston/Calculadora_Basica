TITLE NOME:VICTOR DE MELO ROSTON | RA:22006737

.MODEL SMALL

.DATA
    MSG1 db  10, 13, 'Digite o 1o numero: ','$'         ;DEFININDO AS MENSAGENS    
    MSG2 db  10, 13, 'Digite o 2o numero: ','$'
    MSG3 db  10, 13, 'RESULTADO: ','$'
    MSG4 db  10, 13, 'CONTAS ARITIMETICAS','$'
    MSG5 db  10, 13,  ' ESCOLHA A OPERACAO A SER REALIZADA:','$'
    MSG6 db  10, 13, '  1-SOMA','$'
    MSG7 db  10, 13, '  2-SUBTRACAO','$'
    MSG8 db  10, 13, '  3-MULTIPLICACAO','$'
    MSG9 db  10, 13, '  4-DIVISAO','$'
    MSG10 db  10, 13, '   >','$'
    MSG11 db  10, 13, ' CARACTER INVALIDO, TENTE DENOVO:','$'
    msg12 db  10, 13, ' [APERTE QUALQUER TECLA]','$'
    MSG13 db  10, 13, ' [DIGITE DE 1 A 4 PARA ESCOLHER, OU 9 PARA FECHAR]','$'
    MSG14 db  10, 13, '  9-FINALIZAR PROGRAMA','$'
    MSG15 db  10, 13, '  ///OBRIGADO POR USAR\\\','$'
    MSG16 db  10, 13, ' GOSTARIA DE CONTINUAR?','$'
    MSG17 db  10, 13, ' SIM - APERTE 1','$'
    MSG18 db  10, 13, ' NAO - APERTE QUALQUER TECLA','$'
    MSG19 db  10, 13, 10, 13,  '          CALCULADORA BASICA','$'
    PULA_LINHA db 10, 13, '$'
    SINAL_NEGATIVO db '-', '$'
    
    AUXILIAR DB ?

    NUM1 DB ?                                    ;DEFININDO ESPACO PARA ARMAZENAR OS NUMEROS
    NUM2 DB ?
    RESULTADO DB ?

.CODE
MAIN PROC
    MOV AX,@DATA        
    MOV DS,AX           ;ININICIALIZA O DATA
    MOV ES,AX

    CALL PRIMEIRA_PAGINA

REINICIA_PROGRAMA:
    CALL COR_DE_FUNDO   ; COR DE FUNDO

    CALL SUMARIO

 CARACTER_INVALIDO:
    MOV AH,01H          ; ENTRADA DE 1 A 4 PARA ESCOLHER QUAL OPERACAO FAZER
    SUB AL,30H
    INT 21H

    CMP AL, '1'         ; CASO ENTRADA SEJA 1, COMPARA AL COM 1, SE IGUAL PULA PARA ADICAO
    JE ADICAO

    CMP AL, '2'         ; CASO ENTRADA SEJA 2, COMPARA AL COM 2, SE IGUAL PULA PARA SUBTRACAO
    JE SUBTRACAO

    CMP AL, '3'         ; CASO ENTRADA SEJA 3, COMPARA AL COM 3, SE IGUAL PULA PARA MULTIPLICACAO
    JE MULTIPLICACAO

    CMP AL, '4'         ; CASO ENTRADA SEJA 4, COMPARA AL COM 4, SE IGUAL PULA PARA DIVISAO
    JE DIVISAO

    CMP AL, '9'         ; CASO ENTRADA SEJA 9, COMPARA AL COM 9, SE IGUAL TERMINA O PROGRAMA
    JE FIM

    LEA DX, PULA_LINHA  ; PULA LINHA
    CALL IMPRIMIR_MSG

    LEA DX, MSG11       ; IMPRIME MSG11
    CALL IMPRIMIR_MSG

    LEA DX, MSG10       ; IMPRIME MSG10
    CALL IMPRIMIR_MSG

    JMP CARACTER_INVALIDO

REINICIA_PROGRAMA2:
    JMP REINICIA_PROGRAMA

 ADICAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL CALCULAR_SOMA

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    CALL QUER_CONTINUAR
        JE REINICIA_PROGRAMA

    CALL ENCERRA_PROGRAMA


SUBTRACAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL TESTE_POSITIVO_NEGATIVO
        JL RESULTADO_NEGATIVO

    CALL SUBTRACAO_RESULTADO_POSITIVO

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    CALL QUER_CONTINUAR
        JE REINICIA_PROGRAMA

    CALL ENCERRA_PROGRAMA

RESULTADO_NEGATIVO:

    CALL SUBTRACAO_RESULTADO_NEGATIVO

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    CALL QUER_CONTINUAR
        JE REINICIA_PROGRAMA

    CALL ENCERRA_PROGRAMA


MULTIPLICACAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL CALCULAR_MULTIPLICACAO

    CALL OUTPUT         ; CHAMA A FUNÇÃO "OUTPUT"

    CALL QUER_CONTINUAR
       JE REINICIA_PROGRAMA2

    CALL ENCERRA_PROGRAMA


DIVISAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL QUER_CONTINUAR
        JE REINICIA_PROGRAMA2

    CALL ENCERRA_PROGRAMA


FIM:
    CALL ENCERRA_PROGRAMA

MAIN ENDP

; MUDA A COR DO FUNDO DA TELA E TAMBEM APAGA O CONTEUDO PREVIO IMPRESSO NA TELA
COR_DE_FUNDO PROC
    MOV AH,00
    MOV AL,03h
    INT 10H

    MOV AH,09
    MOV AL,20H
    MOV BH,00
    MOV BL,6FH
    MOV CX,800H
    INT 10H

    RET
COR_DE_FUNDO ENDP


PRIMEIRA_PAGINA PROC
    MOV AH,00
    MOV AL,00
    INT 10H

    MOV AH,09
    MOV AL,20H
    MOV BH,00
    MOV BL,9FH
    MOV CX,800H
    INT 10H

    LEA DX, MSG19
    CALL IMPRIMIR_MSG

    XOR CX, CX
    MOV CX, 16
    PL:
    LEA DX, PULA_LINHA
    CALL IMPRIMIR_MSG
    LOOP PL

    LEA DX, MSG12
    CALL IMPRIMIR_MSG

    MOV AH, 01H
    INT 21H

    RET
PRIMEIRA_PAGINA ENDP

; IMPRIME UM SUMARIO DAS OPERACOES QUE PODEM SER SELECIONADAS
SUMARIO PROC
    ;SELECIONA A OPERACAO
    LEA DX, MSG5        ; IMPRIME MSG5
    CALL IMPRIMIR_MSG

    LEA DX, MSG6        ; IMPRIME MSG6
    CALL IMPRIMIR_MSG

    LEA DX, MSG7        ; IMPRIME MSG7
    CALL IMPRIMIR_MSG

    LEA DX, MSG8        ; IMPRIME MSG8
    CALL IMPRIMIR_MSG

    LEA DX, MSG9        ; IMPRIME MSG9
    CALL IMPRIMIR_MSG

    LEA DX, MSG14       ; IMPRIME MSG14
    CALL IMPRIMIR_MSG

    LEA DX, PULA_LINHA  ; PULA LINHA
    CALL IMPRIMIR_MSG

    LEA DX, MSG13       ; IMPRIME MSG 13
    CALL IMPRIMIR_MSG

    LEA DX, MSG10       ; IMPRIME MSG10
    CALL IMPRIMIR_MSG

    RET
SUMARIO ENDP

; ENTRADA DE CARACTERE PELO TECLADO
INPUT PROC
 NUMERO_INVALIDO:
    LEA DX, MSG1        ; PRINT O MSG1 NA TELA
    CALL IMPRIMIR_MSG

    MOV AH,01H
    INT 21H             ; FAZ A ENTRADA DO PRIMEIRO NÚMERO
    
    CMP AL, 57          ; CASO ENTRADA MAIOR QUE 9 DA TABELA ASCII, REPETE A ENTRADA
    JG NUMERO_INVALIDO

    CMP AL, 48          ; CASO ENTRADA MENOR QUE 0 DA TABELA ASCII, REPETE A ENTRADA
    JL NUMERO_INVALIDO
    
    SUB AL,30H          ; PASSA O CARACTER PARA NUMERO
    MOV NUM1, AL        ; ARMAZENA O NUMERO EM "NUM1"


 NUMERO_INVALIDO2:
    LEA DX, MSG2        ; PRINT O MSG2 NA TELA
    CALL IMPRIMIR_MSG

    MOV AH,01H
    INT 21H             ; FAZ A ENTRADA DO SEGUNDO NÚMERO

    CMP AL, 57          ; CASO ENTRADA MAIOR QUE 9 DA TABELA ASCII, REPETE A ENTRADA
    JG NUMERO_INVALIDO2

    CMP AL, 48          ; CASO ENTRADA MENOR QUE 0 DA TABELA ASCII, REPETE A ENTRADA
    JL NUMERO_INVALIDO2

    SUB AL,30H          ; PASSA O CARACTER PARA NUMERO
    MOV NUM2, AL        ; ARMAZENA O NUMERO EM "NUM2"

    RET
INPUT ENDP

; CONVERSAO DO RESULTADO EM 2 NUMEROS DE 2 BITS PARA IMPRIMIR NA TELA
OUTPUT PROC
    XOR AX, AX          ; ZERA O CONTEÚDO DE AX
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

; SOMA
CALCULAR_SOMA PROC
    MOV DL, NUM1        
    ADD DL, NUM2        ; FAZ A SOMA DOS NUMERO E ARMAZENA EM "RESULTADO"
    MOV RESULTADO, DL

    LEA DX, MSG3        ; PRINT O MSG3 NA TELA
    CALL IMPRIMIR_MSG

    RET
CALCULAR_SOMA ENDP

; SUBTRACAO
TESTE_POSITIVO_NEGATIVO PROC
    MOV AL, NUM1        ;NO CASO DA SUBTRACAO, CASO SEGUNDO VALOR MAIOR QUE O PRIMEIRO, RESULTADO SERA NEGATIVO
    MOV BL, NUM2        ; PARA ISSO COMPARAMOS NUM1 E NUM2, CASO POSITIVO IGNORA O PULO PARA "RESULTADO_NEGATIVO"
    CMP AL, BL          ; E RESOLVE A CONTA NUM1-NUM2, CASO CONTRARIO, PULA PARA "RESULTADO_NEGATIVO" E FAZ NUM2-NUM1
                        ; E ADICIONA O SINAL DE NEGATIVO ANTES DA RESPOSTA FINAL

    RET
TESTE_POSITIVO_NEGATIVO ENDP

SUBTRACAO_RESULTADO_POSITIVO PROC
    MOV DL, NUM1        
    SUB DL, NUM2        ; FAZ A SUBTRACAO DOS NUMERO E ARMAZENA EM "RESULTADO"
    MOV RESULTADO, DL

    LEA DX, MSG3
    MOV AH, 09H         ; PRINT O MSG3 NA TELA
    INT 21H

    RET
SUBTRACAO_RESULTADO_POSITIVO ENDP

SUBTRACAO_RESULTADO_NEGATIVO PROC
    MOV DL, NUM2
    SUB DL, NUM1
    MOV RESULTADO, DL

    LEA DX, MSG3
    MOV AH, 09H         ; PRINT O MSG3 NA TELA
    INT 21H

    LEA DX, SINAL_NEGATIVO
    MOV AH, 09H
    INT 21H

    RET
SUBTRACAO_RESULTADO_NEGATIVO ENDP

; MULTIPLICACAO
CALCULAR_MULTIPLICACAO PROC
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

    LEA DX, MSG3        ; PRINT O MSG3 NA TELA
    CALL IMPRIMIR_MSG

    RET
CALCULAR_MULTIPLICACAO ENDP

; FIM DE PROGRAMA
ENCERRA_PROGRAMA PROC
    LEA DX, PULA_LINHA
    CALL IMPRIMIR_MSG

    LEA DX, MSG15
    CALL IMPRIMIR_MSG

    MOV AH, 4CH         ; ENCERRA O PROGRAMA!
    INT 21H
    RET
ENCERRA_PROGRAMA ENDP

; AUTOMATIZACAO DO PROCESSO DE IMPRIMIR
IMPRIMIR_MSG PROC
    MOV AH,09H
    INT 21H
    RET
IMPRIMIR_MSG ENDP

; REINICIA O PROGRAMA APOS UMA CONTA CASO USUARIO DESEJE
QUER_CONTINUAR PROC
    LEA DX, PULA_LINHA
    MOV AH, 09H
    INT 21H

    LEA DX, MSG16
    MOV AH, 09H
    INT 21H

    LEA DX, MSG17
    MOV AH, 09H
    INT 21H

    LEA DX, MSG18
    MOV AH, 09H
    INT 21H

    LEA DX, MSG10
    MOV AH, 09H
    INT 21H

    MOV AH, 01
    INT 21H
    SUB AL, 30H
    MOV BH, 1

    CMP AL, BH

    RET
QUER_CONTINUAR ENDP

END MAIN