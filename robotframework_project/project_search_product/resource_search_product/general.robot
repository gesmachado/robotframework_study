*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Process
Library    ExcelLibrary


*** Variables ***

*** Keywords ***
Print Remaining Time Seconds
  [arguments]   ${time_seconds}
  Log To Console    \nStarting a sleep time of ${time_seconds} seconds
  FOR    ${i}    IN RANGE    ${time_seconds}
      Sleep    1s
      Log To Console    Waiting for ${i}s
  END

# Excel
Create Excel File
  [arguments]  ${excel_file}

  ${excel_path}  Set Variable    ${EXECDIR}/robotframework_project/project_search_product/search_item_${excel_file}.xlsx

  Create Excel Document 	doc_id=docname1
  Save Excel Document    filename=${excel_path}
  Close Current Excel Document

  Log To Console    messag=Arquivo de Excel criado -> ${excel_path}

Write Excel File
  [arguments]  ${row}  ${col}  ${value}  ${excel_file}

  ${excel_path}  Set Variable    ${EXECDIR}/robotframework_project/project_search_product/search_item_${excel_file}.xlsx
  Log To Console    message=Linha:${row}/Coluna:${col} -> ${value}

  Open Excel Document    filename=${excel_path}   doc_id=docname1
  Write Excel Cell    row_num=${row}    col_num=${col}   value=${value}  sheet_name=Sheet
  Save Excel Document    filename=${excel_path}
  Close Current Excel Document

  Log To Console    message=Foi escrito com sucesso no arquivo de Excel -> ${excel_path}

Write Item and Price on Excel
  [arguments]  ${item_list}  ${price_list}  ${web_site_name}
  ${len_item}  Get Length    ${item_list}
  ${len_price}  Get Length    ${price_list}

  FOR  ${k_item}  IN RANGE  ${len_item}
    ${row_line_item}  Evaluate    ${k_item}+2
    Write Excel File    row=${row_line_item}    col=1    value=${item_list}[${k_item}]  excel_file=${excel_file}
    Write Excel File    row=${row_line_item}    col=3    value=${web_site_name}  excel_file=${excel_file}
  END
  FOR  ${k_price}  IN RANGE  ${_len_price}
    ${row_line_price}  Evaluate    ${k_price}+2
    Write Excel File    row=${row_line_price}    col=2    value=${price_list}[${k_price}]  excel_file=${excel_file}
  END
