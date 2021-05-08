*** Settings ***
# Library
Library   SeleniumLibrary
Library   OperatingSystem
Library   String
Library   Collections
# Resources
Resource  ../resource_search_product/general.robot


*** Variables ***
${tf_input_search}       //*[@id="twotabsearchtextbox"]
${bt_search}             //*[@id="nav-search-submit-button"]
${tb_search}             //*[@id="search"]//div[@class="s-main-slot s-result-list s-search-results sg-row"]
${tf_elements_quantity}  //*[@id="search"]//div[@class="a-section a-spacing-small a-spacing-top-small"]/span[1]
${tf_pagination}         //*[@id="search"]//ul[@class="a-pagination"]

*** Keywords ***
# Saraiva
Search Item in Saraiva Website
  [arguments]  ${item}
  Log To Console    message=Busca de ${item} no site da Saraiva
