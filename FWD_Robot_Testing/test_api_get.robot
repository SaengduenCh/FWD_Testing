*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn
Library     RequestsLibrary
Library     Collections

*** Variable ***
${host_url}    https://jsonplaceholder.typicode.com
${user_id}    1
${accept_type}    application/json; charset=utf-8

*** Test Cases ***
Test5_GET Method
    [Tags]    api
    ${response_data_json}    Call API GET Method    ${user_id}
    Validate Data    ${response_data_json}

*** Keywords ***
Call API GET Method
    [Documentation]   Call API GET Method
    [Arguments]     ${user_id}
    ${params}    Create Dictionary    id=${user_id}
    Create session    get-customer-detail    ${host_url}
    ${response}    GET On Session    get-customer-detail    users    ${params}

    #Get Response Code
    ${http_response_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${http_response_code}    200

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
     Should Be Equal As Integers    ${response_data_json[0]['id']}    ${1}
     Should Be Equal As Strings    ${response_data_json[0]['name']}    Leanne Graham
     Should Be Equal As Strings    ${response_data_json[0]['username']}    Bret
     Should Be Equal As Strings    ${response_data_json[0]['email']}   Sincere@april.biz
     Should Be Equal As Strings    ${response_data_json[0]['address']['street']}    Kulas Light
     Should Be Equal As Strings    ${response_data_json[0]['address']['suite']}    Apt. 556
     Should Be Equal As Strings    ${response_data_json[0]['address']['city']}    Gwenborough
     Should Be Equal As Strings    ${response_data_json[0]['address']['zipcode']}    92998-3874
     Should Be Equal As Strings    ${response_data_json[0]['address']['geo']['lat']}    -37.3159
     Should Be Equal As Strings    ${response_data_json[0]['address']['geo']['lng']}    81.1496
     Should Be Equal As Strings    ${response_data_json[0]['phone']}    1-770-736-8031 x56442
     Should Be Equal As Strings    ${response_data_json[0]['website']}    hildegard.org
     Should Be Equal As Strings    ${response_data_json[0]['company']['name']}    Romaguera-Crona
     Should Be Equal As Strings    ${response_data_json[0]['company']['catchPhrase']}    Multi-layered client-server neural-net
     Should Be Equal As Strings    ${response_data_json[0]['company']['bs']}    harness real-time e-markets