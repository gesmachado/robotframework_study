*** Settings ***

*** Variables ***

*** Test Cases ***
Test 1 - Only IF
  Log To Console    message=\n

  ${var_1}  Set Variable    2
  ${var_2}  Set Variable    2

  IF  "${var_1}"=="${var_2}"
    Log To Console    message=${var_1} é igual a ${var_2}
  END

Test 2 - IF ELSE
  Log To Console    message=\n

  ${var_1}  Set Variable    2
  ${var_2}  Set Variable    3

  IF  "${var_1}"=="${var_2}"
    Log To Console    message=${var_1} é igual a ${var_2}
  ELSE
    Log To Console    message=${var_1} não é igual a ${var_2}
  END

Test 3 - IF ELSE-IF
  Log To Console    message=\n

  ${var_1}  Set Variable    3

  IF  "${var_1}"=="1"
    Log To Console    message= Valor é ${var_1} = 1
  ELSE IF  '${var_1}'=='2'
    Log To Console    message=Valor é ${var_1} = 2
  ELSE
    Log To Console    message=Valor de ${var_1} é invalido
  END

*** Keywords ***
