*** Settings ***

*** Variables ***

*** Test Cases ***
Teste - Mudando nivel de login
  Set Log Level    Trace   # Muda o nivel de log INFO, Debug, Trace

Teste - Logando variaveis do Sistema
  Log Variables

  ${var_1}  Set Variable    Variavel 1

  Log Variables

Teste - Log Many Exemplos
  ${var_1}  Set Variable    Variavel 1
  ${var_2}  Set Variable    Variavel 2
  Log Many  ${var_1}  ${var_2}

Teste - Logando no Console
  Log To Console    \n
  Log To Console    Estou logando no Console 1
  Log To Console    Estou logando no Console 2
  Log To Console    \tEstou logando no Console 3
  Log To Console    \n
  Comment    dsdsdss


Teste - Log comum
  Log    Log 1
  Log    Log 2

*** Keywords ***
