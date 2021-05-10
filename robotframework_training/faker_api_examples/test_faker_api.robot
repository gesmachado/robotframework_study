*** Settings ***
Library   RequestsLibrary
Resource  resource_faker_api.robot

Test Setup     Criar Sessao  ${ALIAS_GLOBAL}  ${URL_GLOBAL}
Test Teardown  Encerrar Sessao

*** Variables ***
${ALIAS_GLOBAL}  fakerapi
${URL_GLOBAL}    https://fakerapi.it/api/v1

*** Test Cases ***
Teste de Get
  Get Address    alias=${ALIAS_GLOBAL}    qtd=2

  Get Companies    alias=${ALIAS_GLOBAL}    qtd=2

  Get Books    alias=${ALIAS_GLOBAL}    qtd=2

  Get Credit Cards    alias=${ALIAS_GLOBAL}    qtd=2

  Get Images    alias=${ALIAS_GLOBAL}    type=any    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=animals    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=architecture    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=nature    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=people    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=tech    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=kittens    height=300    width=200  qtd=1
  Get Images    alias=${ALIAS_GLOBAL}    type=pokemon    height=300    width=200  qtd=1

  Get Persons    alias=${ALIAS_GLOBAL}    gender=male    year=1999    month=01    day=14  qtd=1

  Get Places    alias=${ALIAS_GLOBAL}    qtd=2

  Get Products    alias=${ALIAS_GLOBAL}    taxes=10    categories_type=integer    price_min=10.34    price_max=32.97  qtd=1
  Get Products    alias=${ALIAS_GLOBAL}    taxes=10    categories_type=string    price_min=10.34    price_max=32.97  qtd=1
  Get Products    alias=${ALIAS_GLOBAL}    taxes=10    categories_type=uuid    price_min=10.34    price_max=32.97  qtd=1

  Get Texts    alias=${ALIAS_GLOBAL}    characters=340  qtd=1

  Get Users    alias=${ALIAS_GLOBAL}     gender=male  qtd=2

*** Keywords ***
