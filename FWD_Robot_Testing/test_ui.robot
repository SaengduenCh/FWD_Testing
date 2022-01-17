*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn

*** Variables ***
${web_url}    https://www.apple.com/th/
${browser}    chrome
${button_buy_iphone}            //html/body/main/section[2]/div[1]/div/div/div[1]/div/a[2]
${button_select_model}          //*[@id="root"]/div[2]/div[2]/div[2]/div[2]/div[1]/fieldset/div/div[2]
${button_select_color}          //*[@id="root"]/div[2]/div[2]/div[2]/div[2]/div[2]/fieldset/div/div[4]
${button_select_capacity}       //*[@id="root"]/div[2]/div[2]/div[2]/div[2]/div[3]/fieldset/div/div[3]
${button_add_to_basket}         //*[@id="root"]/div[2]/div[2]/div[2]/div[4]/div[1]/div/div[3]/div/form/div/span/button
${button_look_to_basket}        //*[@id="root"]/div[2]/div/div/div[2]/div/form/button

${model}          //*[@class="rc-dimension-selector-row form-selector"][2]//*[@class="as-dimension-chicklets"]
${color}          //*[@class="rc-dimension-multiple form-selector-swatch column large-6 small-6 form-selector"][4]//span[2]
${capacity}       //*[@class="rc-dimension-multiple form-selector-threeline column large-6 small-6 form-selector"][3]//span[1][@class="form-selector-title"]
${price}          //*[@class="rc-dimension-multiple form-selector-threeline column large-6 small-6 form-selector"][3]//span[1][@class="price-point price-point-fullPrice-short"]

${expec_model}          iPhone 13 Pro Max
${expec_color}          กราไฟต์
${expec_capacity}       512GB
${expec_price}          ฿54,900.00

${basket_price}    //*[@id="bag-content"]/ol/li/div/div[2]/div[1]/div[3]/div[1]/p
${basket_spec}     //*[@id="bag-content"]/ol/li/div/div[2]/div[1]/div[1]/h2/a

*** Test Cases ***
Test7_Buy iPhone From Apple Website
    [Tags]    ui
    Select Item And Add To Basket
    Verify Payment Screen
    Close window

*** Keywords ***
Select Item And Add To Basket
    Open Browser    ${web_url}   browser=${browser}
    Maximize Browser Window
    Set Selenium Speed    0.1s
    Wait Until Element Is Visible    ${button_buy_iphone}    timeout=30s
    Click Element    ${button_buy_iphone}

    #Select Product item
    Wait Until Element Is Visible    ${button_select_model}    timeout=30s
    Click Element    ${button_select_model}
    ${text_model}     Get Text    ${model}
    Set Test Variable    ${text_model}
    Should Be Equal As Strings    ${text_model}    ${expec_model}

    Wait Until Element Is Visible    ${button_select_color}     timeout=30s
    Click Element      ${button_select_color}
    ${text_color}     Get Text     ${color}
    Set Test Variable    ${text_color}
    Should Be Equal As Strings    ${text_color}    ${expec_color}

    Wait Until Element Is Visible    ${button_select_capacity}     timeout=30s
    Click Element    ${button_select_capacity}
    ${text_capacity}     Get Text          ${capacity}
    Set Test Variable    ${text_capacity}

    ${text_price}     Get Text    ${price}
    Set Test Variable    ${text_price}
    Should Be Equal As Strings    ${text_price}    ${expec_price}

    Wait Until Element Is Visible    ${button_add_to_basket}     timeout=30s
    Click Element    ${button_add_to_basket}

    Wait Until Element Is Visible    ${button_look_to_basket}     timeout=30s
    Click Element    ${button_look_to_basket}

Verify Payment Screen
    ${text_basket_price}     Get Text    ${basket_price}
    ${text_basket_spec}     Get Text    ${basket_spec}
    Should Be Equal    ${text_basket_price}    ${expec_price}
    Should Contain	${text_basket_spec}	    ${expec_model}
    Should Contain	${text_basket_spec}	    ${expec_color}
    Should Contain	${text_basket_spec}	    ${expec_capacity}


