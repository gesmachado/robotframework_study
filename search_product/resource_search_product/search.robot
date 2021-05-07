*** Settings ***
# Libraries
Library  SeleniumLibrary
Library  OperatingSystem
Library  String
Library  Collections
# Resources
Resource  search_amazon.robot

*** Variables ***
@{supported_websites}=  https://www.amazon.com.br/

*** Keywords ***
# Main
Search Item
  [arguments]  ${item}  ${excel_file}

  # Tratamento site atual
  ${site_read}=  Get Location

  FOR  ${site}  IN  @{supported_websites}
    IF  '${site}' in '${site_read}'
      IF  '${site_read}' == 'https://www.amazon.com.br/'
        Search Item in Amazon Website  ${item}  ${excel_file}
      ELSE IF  '${site_read}' == 'https://www.saraiva.com.br/'
        Search Item in Saraiva Website  ${item}  ${excel_file}
      ELSE
        Log To Console    message=O site lido -> ${site_read} -> Não encontrado
      END
    END
  END

# Auxiliar - not execute directly
