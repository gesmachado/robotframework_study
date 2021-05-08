*** Settings ***
Library  RequestsLibrary

*** Variables ***

*** Test Cases ***
Teste de Get 1
  Create Session    alias=fakerapi    url=https://fakerapi.it/api/v1
  ${response}  Get On Session    alias=fakerapi  url=/addresses?_quantity=10    expected_status=200
  Log To Console    message=${response.text}
*** Keywords ***
