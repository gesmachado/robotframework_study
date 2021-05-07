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
${bt_next_page_enable}   //*[@id="search"]//ul[@class="a-pagination"]//li[@class="a-last"]
${bt_next_page_disable}   //*[@id="search"]//ul[@class="a-pagination"]//li[@class="a-disabled a-last"]


*** Keywords ***
# Amazon
Search Item in Amazon Website
  [arguments]  ${item}  ${excel_file}
  Log To Console    message=Busca de "${item}" no site da Amazon

  # Fazendo a pesquisa
  Doing a search  ${item}

  # Coletando os dados
  ${item_list}  ${price_list}  Get item name and Price on Page  ${item}

  # Escrevendo no Excel
  Write Item and Price on Excel    ${item_list}  ${price_list}  Amazon

# Auxiliar
# Pesquisar item
Doing a search
  [arguments]  ${item}
  Should Exist    ${tf_input_search}
  Input Text    ${tf_input_search}  ${item}
  Click Element    ${bt_search}
  Print Remaining Time Seconds    10

# Get elements
Get search quantity result one page
  Wait Until Element Is Visible    ${tf_elements_quantity}
  ${tf_elements_quantity_message}=                         Get WebElement          ${tf_elements_quantity}

  ${result}  Split String    ${tf_elements_quantity_message.text}  ${SPACE}

  [Return]  ${result}[0]

Get search quantity result multiple page
  Wait Until Element Is Visible    ${tf_elements_quantity}
  ${tf_elements_quantity_message}=                         Get WebElement          ${tf_elements_quantity}
  Log To Console    ${tf_elements_quantity_message.text}

  ${result}  Split String    ${tf_elements_quantity_message.text}  ${SPACE}
  ${result_2}  Split String    ${result}[0]  -
  Log To Console    ${result_2}

  [Return]  ${result}[0]

# Get String
Get Element String Name
  [arguments]  ${element_path}
  ${element_path_message}=                         Get WebElement          ${element_path}

  [Return]  ${element_path_message.text}

Get Element String Price
  [arguments]  ${tf_price_full}

  ${tf_element_1}  Set Variable    ${tf_price_full}//span[@class="a-price-whole"]
  ${tf_element_3}  Set Variable    ${tf_price_full}//span[@class="a-price-fraction"]

  # 1
  ${element_1_message}=                         Get WebElement          ${tf_element_1}
  # 3
  ${element_3_message}=                         Get WebElement          ${tf_element_3}

  # ${price}  Evaluate    ${element_1_message.text}.${element_3_message.text}
  ${price}  Catenate    ${element_1_message.text},  ${element_3_message.text}

  [Return]  ${price}

Verify Price Exist
  [arguments]  ${tf_price_full}
  ${status}=    Run Keyword And Return Status     Page Should Contain Element    ${tf_price_full}

  [return]  ${status}

# Get Page
Get Page
  ${status}=    Run Keyword And Return Status     Page Should Contain Element    ${tf_pagination}

  [return]  ${status}

Get Quantity of Page

  ${number}  Get Element String Name    ${tf_last_page_number}

  [return]  ${number}

# Searching by item
Get item name and Price on Page
  [arguments]  ${item}
  # Criando as listas
  @{item_list}  Create List
  @{price_list}  Create List

  ${j}  Set Variable    1

  FOR  ${i}  IN RANGE  9999999
    # ${j}  Evaluate    ${i}+1

    ${tf_element_full}  Set Variable    ${tb_search}/div[${j}]
    ${tf_element_name}  Set Variable    ${tf_element_full}//span[@class="a-size-base-plus a-color-base a-text-normal"]
    ${tf_price_full}  Set Variable      ${tf_element_full}//span[@class="a-price"]

    ${status_element_name}=    Run Keyword And Return Status     Page Should Contain Element    ${tf_element_name}
    ${status_element_full}=    Run Keyword And Return Status     Page Should Contain Element    ${tf_element_full}


    IF  '${status_element_full}'=='True'
      Log To Console    message=Existe um elemento pra iterar seja válido ou não
      IF  '${status_element_name}'=='True'
        Log To Console    message=O elemento encontrado é valido

        # Get Element Name
        ${element_name}  Get Element String Name    ${tf_element_name}

        # Get Element Price
        ${price_result_verify}=  Verify Price Exist  ${tf_price_full}

        IF  '${price_result_verify}'=='True'
          ${element_price}  Get Element String Price    ${tf_price_full}

          Append To List      ${item_list}            ${element_name}
          Append To List      ${price_list}           ${element_price}

          Log To Console    message=${element_name} -> ${element_price}
          ${j}  Evaluate    ${j}+1
          Log To Console    message=Próxima iteração indice será ${j}
          # Print Remaining Time Seconds    5

        ELSE IF  '${price_result_verify}'=='False'
          Log To Console    message=O item ${element_name} não possui preço
          ${j}  Evaluate    ${j}+1
        END
      ELSE IF  '${status_element_name}'=='False'
        Log To Console    message=Elemento não é válido, pular pra próxima iteração
        ${j}  Evaluate    ${j}+1
        Continue For Loop
      END
    ELSE IF  '${status_element_full}'=='False'
      ${get_page_result}=  Get Page
      IF  'True'=='${get_page_result}'
        Log To Console    message=Pesquisa tem mais de uma página

        # Clicar no botão pra mudar de página se ele estiver disponivel
        ${status_next_page}=    Run Keyword And Return Status     Page Should Contain Element    ${bt_next_page_enable}

        IF  'True'=='${status_next_page}'
          Log To Console    message=Existe uma outra página, mudando para próxia página
          Click Element    ${bt_next_page_enable}
          Print Remaining Time Seconds    10
          ${j}  Set Variable    1
          Log To Console    message= Resetei iterado Próximo será -> ${j}

        ELSE IF  'False'=='${status_next_page}'
          Log To Console    message=Não existem mais páginas
          Exit For Loop
        END
      ELSE IF  'False'=='${get_page_result}'
        Log To Console    message=Todos os elementos da página terminaram e não existe uma segunda página
        Exit For Loop
      END

      # Log To Console    message=Não existe nenhum elemento pra iterar
      # Exit For Loop
    END

    ############################################################################
    # ${status}=    Run Keyword And Return Status     Page Should Contain Element    ${tf_element_name}
    # # Verificação se o elemento existe segundo o ${status} coletado
    # IF  'True'=='${status}'
    #   ####
    #   # Get Element Name
    #   ${element_name}  Get Element String Name    ${tf_element_name}
    #
    #   # Get Element Price
    #   ${price_result_verify}=  Verify Price Exist  ${tf_price_full}
    #
    #   IF  '${price_result_verify}'=='True'
    #     ${element_price}  Get Element String Price    ${tf_price_full}
    #
    #     Append To List      ${item_list}            ${element_name}
    #     Append To List      ${price_list}           ${element_price}
    #
    #     Log To Console    message=${element_name} -> ${element_price}
    #
    #   ELSE IF  '${price_result_verify}'=='False'
    #     Log To Console    message=O item ${element_name} não possui preço
    #   END
    #   ###
    # ELSE IF  'False'=='${status}'
    #   ${get_page_result}=  Get Page
    #   IF  'True'=='${get_page_result}'
    #     Log To Console    message=Pesquisa tem mais de uma página
    #
    #     # Clicar no botão pra mudar de página se ele estiver disponivel
    #     ${status_next_page}=    Run Keyword And Return Status     Page Should Contain Element    ${bt_next_page_enable}
    #
    #     IF  'True'=='${status_next_page}'
    #       Log To Console    message=Existe uma outra página, mudando para próxia página
    #       Click Element    ${bt_next_page_enable}
    #       Print Remaining Time Seconds    10
    #     ELSE IF  'False'=='${status_next_page}'
    #       Log To Console    message=Não existem mais páginas
    #       Exit For Loop
    #     END
    #   ELSE IF  'False'=='${get_page_result}'
    #     Log To Console    message=Todos os elementos da página terminaram e não existe uma segunda página
    #     Exit For Loop
    #   END
    #
    # END
    ############################################################################

  END


  [return]  ${item_list}  ${price_list}
