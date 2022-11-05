TITLE NOME:VICTOR DE MELO ROSTON | RA:22006737

.MODEL SMALL

.DATA
    MSG1 db  10, 13,  'Digite o 1o numero: ','$'         ;DEFININDO AS MENSAGENS    
    MSG2 db  10, 13,  'Digite o 2o numero: ','$'
    MSG3 db  10, 13,  ' RESULTADO: ','$'
    MSG4 db  10, 13,  'CONTAS ARITIMETICAS','$'
    MSG5 db  10, 13,  ' ESCOLHA A OPERACAO A SER REALIZADA:','$'
    MSG6 db  10, 13,  '  1-SOMA','$'
    MSG7 db  10, 13,  '  2-SUBTRACAO','$'
    MSG8 db  10, 13,  '  3-MULTIPLICACAO','$'
    MSG9 db  10, 13,  '  4-DIVISAO','$'
    MSG10 db  10, 13, '   >>>','$'
    MSG11 db  10, 13, ' CARACTER INVALIDO, TENTE NOVAMENTE:','$'
    msg12 db  10, 13, ' [APERTE QUALQUER TECLA]','$'
    MSG13 db  10, 13, ' [DIGITE DE 1 A 4 PARA ESCOLHER, OU 9 PARA FECHAR]','$'
    MSG14 db  10, 13, '  9-FINALIZAR PROGRAMA','$'
    MSG15 db          '  ///O PROGRAMA FOI ENCERRADO, OBRIGADO POR USAR\\\','$'
    MSG16 db  10, 13, ' GOSTARIA DE CONTINUAR?','$'
    MSG17 db  10, 13, ' SIM - APERTE 1','$'
    MSG18 db  10, 13, ' NAO - APERTE QUALQUER TECLA','$'
    MSG19 db  10, 13, 10, 13,  '         CALCULADORA BASICA','$'
    MSG20 db  10, 13, ' QUOCIENTE: ','$'
    MSG21 db  10, 13, ' RESTO: ','$'
    MSG22 db  10, 13, ' IMPOSSIVEL DIVIDIR POR 0','$'
    MSG23 db  10, 13, '   ===PROGRAMA FEITO POR VICTOR DE MELO ROSTON===','$'

    PULA_LINHA db 10, 13, '$'
    SINAL_NEGATIVO db '-', '$'
    
    AUXILIAR DB ?

    NUM1 DB ?                                    ;DEFININDO ESPACO PARA ARMAZENAR OS NUMEROS
    NUM2 DB ?
    RESULTADO DB ?
    RESULTADO2 DB ?

.CODE
MAIN PROC
    MOV AX,@DATA        
    MOV DS,AX                   ;ININICIALIZA O DATA
    MOV ES,AX

    CALL PRIMEIRA_PAGINA        ; faz a chamada da tela inicial do programa que apenas exibira o
                                ;  titulo do programa piscando, conteudo que aparecera apenas ao inicializar o programa

REINICIA_PROGRAMA:
    CALL COR_DE_FUNDO           ; apaga tudo da tela e muda a cor de fundo

    CALL SUMARIO                ; imprime as opcoes de operacoes possiveis no programa

CARACTER_INVALIDO:
    MOV AH,01H                  ; ENTRADA DE 1 A 4 PARA ESCOLHER QUAL OPERACAO FAZER
    SUB AL,30H
    INT 21H

    CMP AL, '1'                 ; CASO ENTRADA SEJA 1, COMPARA AL COM 1, SE IGUAL PULA PARA ADICAO
    JE ADICAO

    CMP AL, '2'                 ; CASO ENTRADA SEJA 2, COMPARA AL COM 2, SE IGUAL PULA PARA SUBTRACAO
    JE SUBTRACAO

    CMP AL, '3'                 ; CASO ENTRADA SEJA 3, COMPARA AL COM 3, SE IGUAL PULA PARA MULTIPLICACAO
    JE MULTIPLICACAO

    CMP AL, '4'                 ; CASO ENTRADA SEJA 4, COMPARA AL COM 4, SE IGUAL PULA PARA DIVISAO
    JE DIVISAO

    CMP AL, '9'                 ; CASO ENTRADA SEJA 9, COMPARA AL COM 9, SE IGUAL TERMINA O PROGRAMA
    JE FIM

    LEA DX, PULA_LINHA          ; PULA LINHA
    CALL IMPRIMIR_MSG

    LEA DX, MSG11               ; IMPRIME MSG11
    CALL IMPRIMIR_MSG

    LEA DX, MSG10               ; IMPRIME MSG10
    CALL IMPRIMIR_MSG

    JMP CARACTER_INVALIDO

    REINICIA_PROGRAMA2:
        JMP REINICIA_PROGRAMA

; inicio das operacoes
ADICAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL CALCULAR_SOMA

    JMP TERMINA_OPERACAO


SUBTRACAO:
    CALL COR_DE_FUNDO                   ; chama a funcao para limpar tela e mudar de cor

    CALL INPUT                          ; chama a funcao para entrada de 2 numeros de 0 a 9

    CALL TESTE_POSITIVO_NEGATIVO        ; chama a funcao que testa se a resposta sera positivo ou negativo
        JL RESULTADO_NEGATIVO           ; caso resposta negativo, pula para o caso especial de resposta negativo

    CALL SUBTRACAO_RESULTADO_POSITIVO   ; chama a funcao para calcular a subtracao com resposta positivo

    JMP TERMINA_OPERACAO                ; chama a funcao para exibir a resposta na tela e perguntar se quer fazer 
                                        ;  outra conta ou encerrar o programa
 RESULTADO_NEGATIVO:

    CALL SUBTRACAO_RESULTADO_NEGATIVO   ; chama a funcao que fara a subtracao com o maior numero primeiro, e 
                                        ;  imprimira um resultado de negativo antes da resposta

    JMP TERMINA_OPERACAO                ; chama a funcao para exibir a resposta na tela e perguntar se quer fazer 
                                        ;  outra conta ou encerrar o programa


MULTIPLICACAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL CALCULAR_MULTIPLICACAO
    
    JMP TERMINA_OPERACAO

DIVISAO:
    CALL COR_DE_FUNDO

    CALL INPUT

    CALL DIVISAO_COM_ZERO               ; realiza a verificacao de uma possivel entrada de 0 no segndo numero
        JE PULA4                        ; com a comparacao feita, pula caso algum numero da entrada seja 0

    CALL CALCULAR_DIVISAO

    CALL OUTPUT_QUOCIENTE

    CALL OUTPUT_RESTO


    CALL QUER_CONTINUAR
        JE REINICIA_PROGRAMA2
    
    JMP FIM

PULA4:
    LEA DX, MSG22                       ; imprime a menssagem de impossibilidade de dividir por 0
    CALL IMPRIMIR_MSG
    JMP PULA7

TERMINA_OPERACAO:
    CALL OUTPUT
PULA7:
    CALL QUER_CONTINUAR
        JE REINICIA_PROGRAMA2

FIM:
    CALL ENCERRA_PROGRAMA

MAIN ENDP

; apaga o conteudo impresso na tela e muda a cor de fundo
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

; definindo a primeira tela que apresenta o titulo da calculadora piscando
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
    LEA DX, PULA_LINHA          ; imprime pular linha 15 vezes definido em CX para imprimir MSG12
    CALL IMPRIMIR_MSG
    LOOP PL

    LEA DX, MSG12               ; faz a entrada de um caractere apenas para sair da tela inicial
    CALL IMPRIMIR_MSG           ;  caractere nao ficara salvo e nao tera nenhuma utilidade apos

    MOV AH, 01H
    INT 21H

    RET
PRIMEIRA_PAGINA ENDP

; imprime na tela um sumario das operacoes que podem ser selecionadas
SUMARIO PROC
    LEA DX, MSG5        ; a cada bloco sera feita a impressao de uma das menssagens escritas no .DATA
    CALL IMPRIMIR_MSG

    LEA DX, MSG6        
    CALL IMPRIMIR_MSG

    LEA DX, MSG7        
    CALL IMPRIMIR_MSG

    LEA DX, MSG8        
    CALL IMPRIMIR_MSG

    LEA DX, MSG9        
    CALL IMPRIMIR_MSG

    LEA DX, MSG14       
    CALL IMPRIMIR_MSG

    LEA DX, PULA_LINHA  
    CALL IMPRIMIR_MSG

    LEA DX, MSG13       
    CALL IMPRIMIR_MSG

    LEA DX, MSG10       
    CALL IMPRIMIR_MSG

    RET
SUMARIO ENDP

; entrada dos numeros para a operacao
INPUT PROC
 NUMERO_INVALIDO:
    LEA DX, MSG1        ; imprime MSG1 na tela
    CALL IMPRIMIR_MSG

    MOV AH,01H
    INT 21H             ; faz a entrada do primeiro número da operação
    
    CMP AL, 57          ; como a entrada pode ser qualquer caractere e o programa trabalha
    JG NUMERO_INVALIDO  ;  com entrada de apenas um digito de numero (0 a 9), esse breve sistema 
                        ;  limitara a entrada de caracteres entre 48 (0 na tabela ASCII) a 57 (9 na tabela ASCII),
    CMP AL, 48          ;  fazendo um loop quando a entrada nao for entre 0 a 9
    JL NUMERO_INVALIDO
    
    SUB AL,30H          ; passa o caractere para numero
    MOV NUM1, AL        ; armazena o primeiro numero na variavel NUM1

; mesmos procedimentos, mas para a entrada do segundo numero para a operacao
 NUMERO_INVALIDO2:
    LEA DX, MSG2
    CALL IMPRIMIR_MSG

    MOV AH,01H
    INT 21H

    CMP AL, 57
    JG NUMERO_INVALIDO2

    CMP AL, 48
    JL NUMERO_INVALIDO2

    SUB AL,30H
    MOV NUM2, AL

    RET                 ; o retorno a funcao se dara com a entrada dos dois numeros armazenados em NUM1 e NUM2
INPUT ENDP

; conversao do resultado em 2 numeros de 2 bits e imprime na tela
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

; imprime o quociente da divisao
OUTPUT_QUOCIENTE PROC
    ; realiza a mesma funcao do primeiro output, porem com a menssagem de quociente antes de exibir a resposta
    LEA DX, MSG20
    CALL IMPRIMIR_MSG

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
OUTPUT_QUOCIENTE ENDP

; imprimir o resto da divisao
OUTPUT_RESTO PROC
    ; realiza a mesma funcao do primeiro output, porem com a menssagem de resto antes de exibir a resposta
    LEA DX, MSG21
    CALL IMPRIMIR_MSG

    XOR AX, AX          ; ZERA O CONTEÚDO DE AX
    MOV AL, RESULTADO2   ; PASSA O RESULTADO2 PRA AL
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

    RET
OUTPUT_RESTO ENDP

; caso o segundo numero da entrada seja 0, impossivel realizar divisao por zero
DIVISAO_COM_ZERO PROC
    MOV AH, NUM2            ; conteudo de NUM2 sera passado para o registrador
    CMP AH, 0               ;  para fazer comparacao com zero

    RET                     ; a função retornara com a comparação do segundo numero da entrada
DIVISAO_COM_ZERO ENDP

; soma
CALCULAR_SOMA PROC
    MOV DL, NUM1        
    ADD DL, NUM2        ; FAZ A SOMA DOS NUMERO E ARMAZENA EM "RESULTADO"
    MOV RESULTADO, DL

    LEA DX, MSG3        ; PRINT O MSG3 NA TELA
    CALL IMPRIMIR_MSG

    RET
CALCULAR_SOMA ENDP

; subtracao
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

; multiplicacao
CALCULAR_MULTIPLICACAO PROC
    XOR DX, DX          ; inicializa dx com 0
    MOV CX, 4           ; inicializa cx com 4 para reptir o loop 4 vezes

    MOV BL,NUM1         ; numero que sera adicionado no resultado e rotacionado a esquerda a cada repeticao
    MOV BH,NUM2         ; numero que vai ser a quantidade de vezes que o num1 vai ser adicionado, 
                        ;  sendo esse num2 binario que mandara um valor para a cf, e caso 0 pula 
                        ;  a soma do num1 no resultado e caso 1 adiciona o num1 ao resultado

  VOLTA:
    SHR BH,1            ; MOVIMENTA NUM2 P/ CF (CASO 1 ADICIONA BL AO RESULTADO E DESLOCA O NUM1 
    JNC PULA            ;  PARA ESQUERDA PARA A PROXIMA SOMA, CASO 0 APENAS DESLOCA NUM1 PARA ESQUERDA)
    ADD DL,BL

  PULA:
    SHL BL,1            ; PARA A PROXIMA SOMA E PRECISO PULAR UMA CASA A ESQUERDA
    LOOP VOLTA

    MOV RESULTADO,DL    ; PASSA O VALOR FINA DA MULTIPLICACAO PARA A VARIAVEL RESULTADO

    LEA DX, MSG3        ; print msg3 na tela
    CALL IMPRIMIR_MSG

    RET
CALCULAR_MULTIPLICACAO ENDP

; divisao
CALCULAR_DIVISAO PROC
    XOR AX, AX          ; zera os registradores
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

    MOV AH, NUM2        ; passa para o registrador o conteudo da variavel num2
    MOV CL, 4           ; havera um loop de 4 vezes que usa cx como contador pois
                        ;  a divisao tera no maximo 4 digitos de bits

VOLTA3:
    MOV AL, NUM1        ; o registrador AL recebe num1 como base para fazer para subtrair
    SHR AL, CL
    RCL DL, 1
    CMP AH, DL
    JG PULA5
    SUB DL, AH
    INC DH
PULA5:
    CMP CL, 1
    JE PULA6
    SHL DH, 1
PULA6:
    LOOP VOLTA3

    MOV RESULTADO, DH       ; RESTO
    MOV RESULTADO2, DL      ; QUOCIENTE

    RET
CALCULAR_DIVISAO ENDP

; fim de programa
ENCERRA_PROGRAMA PROC
    CALL COR_DE_FUNDO

    LEA DX, PULA_LINHA  ; pula uma linha
    CALL IMPRIMIR_MSG

    LEA DX, MSG15
    CALL IMPRIMIR_MSG

    LEA DX, PULA_LINHA
    CALL IMPRIMIR_MSG

    LEA DX, MSG23
    CALL IMPRIMIR_MSG

    MOV CX,11           ; inicializa cx com 11
VOLTA1:
    LEA DX, PULA_LINHA
    CALL IMPRIMIR_MSG   ; realiza um loop para imprimir linha 10 vezes
    LOOP VOLTA1


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
    CALL IMPRIMIR_MSG

    LEA DX, MSG16
    CALL IMPRIMIR_MSG

    LEA DX, MSG17
    CALL IMPRIMIR_MSG

    LEA DX, MSG18
    CALL IMPRIMIR_MSG

    LEA DX, MSG10
    CALL IMPRIMIR_MSG

    MOV AH, 01
    INT 21H
    SUB AL, 30H
    MOV BH, 1

    CMP AL, BH

    RET
QUER_CONTINUAR ENDP

END MAIN