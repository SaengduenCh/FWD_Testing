*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn
Library     RequestsLibrary
Library     Collections

*** Variable ***
${host_url}    https://jsonplaceholder.typicode.com
${accept_type}    application/json; charset=utf-8
${title}    ea molestias quasi exercitationem repellat qui ipsa sit aut
${body}    et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut

*** Test Cases ***
Test6_POST Method
    [Tags]    api
    ${response_data_json}    Call API POST Method
    Validate Data   ${response_data_json}

*** Keywords ***
Call API POST Method
    [Documentation]   Call API POST Method
     ${body}    Create Dictionary
     ...    userId=${1},
     ...    title=${title},
     ...    body=${body}

    Create session    post-add-data    ${host_url}
    ${response}    POST On Session    post-add-data    posts   data=${body}   # headers=${headers}

    #Get Response Code
    ${http_response_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${http_response_code}    201

    #Get Content-Type
    ${content_type_response}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${accept_type}    ${content_type_response}

    #Convert to json
    ${response_json}    Set Variable    ${response.json()}
    Log    ${response_json}
    [Return]    ${response_json}

Validate Data
    [Documentation]    Validate Data
    [Arguments]     ${response_data_json}
    Should Be Equal     ${response_data_json['userId']}    ${1},
    Should Be Equal As Strings    ${response_data_json['title']}    ${title},
    Should Be Equal As Strings    ${response_data_json['body']}       ${body}
    Should Be Equal     ${response_data_json['id']}    ${101}
