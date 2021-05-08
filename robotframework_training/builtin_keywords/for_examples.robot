*** Settings ***

*** Variables ***

*** Test Cases ***
Test 1 - FOR Loop
  Log To Console    message=\n
  FOR  ${i}  IN RANGE  10
    Log To Console    message=${i}
  END

Test 2 - FOR loop exit
  Log To Console    message=\n
  FOR  ${i}  IN RANGE  10
    Log To Console    message=${i}
    Exit For Loop
  END

Test 3 - FOR loop exit if
  Log To Console    message=\n
  FOR  ${i}  IN RANGE  10
    Log To Console    message=${i}
    Exit For Loop If    condition=${i}==3
  END

Test 3 - FOR loop Continue
  Log To Console    message=\n
  FOR  ${i}  IN RANGE  10
    Log To Console    message=${i}
    Continue For Loop
    Log To Console    message=Teste
  END

Test 4 - FOR loop Continue If
  Log To Console    message=\n
  FOR  ${i}  IN RANGE  10
    Log To Console    message=${i}
    Continue For Loop If    ${i}>=2
    Log To Console    message=Teste passou do for if
  END
*** Keywords ***
