*** Settings ***
Library  RequestsLibrary

*** Variables ***


*** Keywords ***
# Conexão
Criar Sessao
  [arguments]  ${alias}  ${url}
  Log To Console    message=\n*********************************
  Log To Console    message=Criando Sessão no endereço: ${url}
  Log To Console    message=Alias name: ${alias}
  Log To Console    message=*********************************
  Create Session    alias=${alias}    url=${url}

Encerrar Sessao
  Log To Console    message=Deletando todas as sessões abertas
  Delete All Sessions

# Requests
Get Address
  [arguments]  ${alias}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} endereços
  ${response}  Get On Session    alias=${alias}  url=/addresses?_quantity=${qtd}    expected_status=200

  # Printing
  Print itens     ${response}
  Print specific iten value    response=${response}    key=street

Get Companies
  [arguments]  ${alias}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} companias
  ${response}  Get On Session    alias=${alias}  url=/companies?_quantity=${qtd}    expected_status=200

  # Printing
  Print itens     ${response}

Get Books
  [arguments]  ${alias}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} livros
  ${response}  Get On Session    alias=${alias}  url=/books?_quantity=${qtd}    expected_status=200

  # Printing
  Print itens     ${response}

Get Credit Cards
  [arguments]  ${alias}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} cartões de crédito
  ${response}  Get On Session    alias=${alias}  url=/credit_cards?_quantity=${qtd}    expected_status=200

  # Printing
  Print itens     ${response}

Get Images
  [arguments]  ${alias}  ${type}  ${height}  ${width}  ${qtd}=10

  # type can be = any, animals, architecture, nature, people, tech, kittens, pokemon

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} imagens
  ${response}  Get On Session    alias=${alias}  url=/images?_quantity=${qtd}&_type=${type}&_height=${height}&_width=${width}   expected_status=200

  # Printing
  Print itens     ${response}

Get Persons
  [arguments]  ${alias}  ${gender}  ${year}  ${month}  ${day}  ${qtd}=10

  # type can be = any, animals, architecture, nature, people, tech, kittens, pokemon

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} pessoas
  ${response}  Get On Session    alias=${alias}  url=/persons?_quantity=${qtd}&_gender=${gender}&_birthday_start=${year}-${month}-${day}   expected_status=200

  # Printing
  Print itens     ${response}

Get Places
  [arguments]  ${alias}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} lugares
  ${response}  Get On Session    alias=${alias}  url=/places?_quantity=${qtd}    expected_status=200

  # Printing
  Print itens     ${response}

Get Products
  [arguments]  ${alias}  ${taxes}  ${categories_type}  ${price_min}  ${price_max}  ${qtd}=10

  # _categories_type = integer, string, uuid

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} produtos
  ${response}  Get On Session    alias=${alias}  url=/products?_quantity=${qtd}&_taxes=${taxes}&_categories_type=${categories_type}&_price_min=${price_min}&_price_max=${price_max}    expected_status=200

  # Printing
  Print itens     ${response}

Get Texts
  [arguments]  ${alias}  ${characters}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} textos
  ${response}  Get On Session    alias=${alias}  url=/texts?_quantity=${qtd}&_characters=${characters}    expected_status=200

  # Printing
  Print itens     ${response}

Get Users
  [arguments]  ${alias}  ${gender}  ${qtd}=10

  # Get Request
  Log To Console    message=Realizando Requisição de ${qtd} usuários
  ${response}  Get On Session    alias=${alias}  url=/users?_quantity=${qtd}&_gender=${gender}   expected_status=200

  # Printing
  Print itens     ${response}


# Le a resposta e printa 1 por 1
Print itens
  [arguments]  ${response}

  ${response_total_item}   Convert To String    ${response.json()["total"]}

  FOR  ${i}  IN RANGE  ${response_total_item}

    ${response_data_item_full}   Convert To String    ${response.json()["data"][${i}]}
    Log To Console    message=**************************************************
    Log To Console    message=**** Item Completo de número ${i} ****
    Log To Console    message=${response_data_item_full}
    Log To Console    message=\n
  END
  #
  # [return]  ${response_json_id}

Print specific iten value
  [arguments]  ${response}  ${key}

  ${response_total_item}   Convert To String    ${response.json()["total"]}

  FOR  ${i}  IN RANGE  ${response_total_item}

    ${response_data_item_full}   Convert To String    ${response.json()["data"][${i}]["${key}"]}
    Log To Console    message=**************************************************
    Log To Console    message=**** Item Completo de número ${i} ****
    Log To Console    message=${response_data_item_full}
    Log To Console    message=\n
  END
  #
  # [return]  ${response_json_id}
