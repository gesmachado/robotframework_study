*** Settings ***
Resource  ../resource_search_product/base.robot
Resource  ../resource_search_product/general.robot
Resource  ../resource_search_product/search.robot

Suite Setup     New Session    ${BROWSER}
Suite Teardown  Close Session

*** Variables ***
# Para executar o test: robot -d .\results -L trace search_product\test_search_product\test_search_product.robot
# Foram utilizados várivaies globais hard-coded propositalmente
# Pesquisa é feita em um site por vez e um produot por vez
${IP_SEARCH}      https://www.amazon.com.br/
${BROWSER}        gc
${PRODUCT}        projetor    #Naruto Gold Vol. 60  Bleach
${EXCEL_FILE}     projetor              #naruto_60            bleach

*** Test Cases ***
Test - Search For Product on a Website

  # Criando Excel por produto
  Create Excel File  ${EXCEL_FILE}
  Write Excel File    1    1    Nome do Produto  ${EXCEL_FILE}
  Write Excel File    1    2    Preço do Produto  ${EXCEL_FILE}
  Write Excel File    1    3    Loja  ${EXCEL_FILE}

  Log To Console    message=************************************************
  Log To Console    message=Site acessado:${IP_SEARCH}
  Log To Console    message=Item buscado: ${PRODUCT}
  Log To Console    message=************************************************

  Navegate To    ${IP_SEARCH}
  Print Remaining Time Seconds    1

  # BUSCA
  Search Item  ${PRODUCT}  ${EXCEL_FILE}
