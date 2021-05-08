*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
New Session
  [arguments]  ${browser}
  Open Browser    https://www.google.com.br/  ${browser}
  Maximize Browser Window

Navegate To
  [arguments]  ${ip}
  Go To    ${ip}

Close Session
  Close Browser
