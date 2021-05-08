*** Settings ***

*** Variables ***

*** Test Cases ***
Test 1 - Dictionary

  &{dictionary1}  Create Dictionary    id=1  name=Gustavo  sobrenome=Machado

  Log To Console    \n${dictionary1}[id]
  Log To Console    ${dictionary1}[name]
  Log To Console    ${dictionary1}[sobrenome]

  Should Be True	${dictionary1} == {'id': '1','name':'Gustavo', 'sobrenome': 'Machado'}

  &{dictionary2} =	Create Dictionary	  id  2  name  Gabriel  sobrenome  Machado

  Log To Console    ${dictionary1}
  Log To Console    ${dictionary2}

  Should Be Equal	${dictionary1.id}	 1

  Log To Console    \nPrint das keys values
  Log To Console    ${dictionary1.id}


  # &{dict} =	Create Dictionary	key=value	foo=bar			# key=value syntax
  # Should Be True	${dict} == {'key': 'value', 'foo': 'bar'}
  #
  # Should Be Equal	${dict}	${dict2}
  # &{dict} =	Create Dictionary	${1}=${2}	&{dict}	foo=new		# using variables
  # Should Be True	${dict} == {1: 2, 'key': 'value', 'foo': 'new'}

*** Keywords ***
