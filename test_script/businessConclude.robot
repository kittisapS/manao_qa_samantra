*** Settings ***
Library    SeleniumLibrary
Resource    ../keyword/globalKeyword.robot
Suite Setup    Open Samantra and login    ${urlSTG}    ${chrome}
Test Setup    Go to Business Conclude menu
#Suite Teardown    Close All Browsers
Test Template    Create new business conclude

*** Variables ***

## ----- Business Conclude -----
${btnAddNew}    xpath: //button[contains(text(),'Add New')]
${modalContractType}    xpath: //h4[contains(text(),' Please Select Contract Type ')]/ancestor::div/div[@class='modal-content']
${radioBasis}    xpath: //label[contains(text(),' Basis ')]
${radioFlat}    xpath: //label[contains(text(),' Flat ')]
${btnConfirm}    xpath: //button[contains(text(),'Confirm')]
${btnCancel}    xpath: //button[contains(text(),'cancel')]

## ------ Add New Business Conclude -----
${h4AddBusinessConclude}    xpath: //h4[contains(text(),'Add Business Conclude Page')]
${ddlProduct}    xpath: //label[contains(text(),'Product')]//ng-select
${liProduct}    xpath: //span[text()='SOYBEAN MEAL   - USA']/parent::div
${btnYes}    xpath: //button[text()='Yes']
${radioPlantType}    xpath: //label[text()='AGRO']
${dateConclude}    xpath: //app-date-picker[@id='concludeDate']
${inptPrice}    xpath: //input[@name='price']
${inptBasis}    xpath: 
${inptCBOT}    xpath:
${inptCNF}    xpath:
${inptQTY}    xpath: //input[@name='quantity']
${inptTorelance}    xpath: //input[@id='tolerance']
${radioSeaFreight}    xpath: //label[text()='Conventional Vessel']
${chkPackage}    xpath: //label[text()='Bulk']/preceding-sibling::input
${ddlPayment}    xpath: //ng-select[@name='payment']
${liPayment}    xpath: //span[text()='T/T']/parent::div
${radioPaymentType}    xpath: //label[text()='Sight']/parent::div
${dateShippingStart}    xpath: //app-date-picker[@id='shipmentStartDate']
${dateShippingEnd}    xpath: //app-date-picker[@id='shipmentEndDate']
${ddlTermOfDelivery}    xpath: //ng-select[@name='termOfDelivery']
${liTermOfDelivery}    xpath: //span[text()='FOB']/parent::div
${ddlCustomer}    xpath: //ng-select[@placeholder='Input Buyer Name']
${ddlSupplier}    xpath: //ng-select[@placeholder='Input Seller Name']
${dataSupplier}    xpath: //ng-select[@placeholder='Input Seller Name']//div[@role='option'][1]
${ddlOriginCountry}    xpath: //label[text()='Origin Country ']/ng-select[@placeholder='Input Country Name']
${ddlDestinationCountry}    xpath: //label[text()='Destination Country ']/ng-select[@placeholder='Input Country Name']

## ------ End Add New Business Conclude -----

# ----- Date -----
${dataConcludeDate}     xpath: //ngb-datepicker-month//div[@aria-label='Saturday, May 31, 2025']/div[text()=' 31 ']
${dataShippingStart}     xpath: //ngb-datepicker-month//div[@aria-label='Sunday, June 1, 2025']/div[text()=' 1 ']
${dataShippingEnd}       xpath: //ngb-datepicker-month//div[@aria-label='Monday, June 30, 2025']/div[text()=' 30 ']

*** Test Cases ***        Contract Type        Product                                   Customer                             Destination        Origin         SeaFreight
Case_Flat_1               Flat      U.S. SOLVENT EXTRACTED TOASTED SOYBEAN MEAL - USA    C.P. TRADING COMPANY LIMITED         Thailand        BRA               Conventional Vessel

*** Keywords ***


Create new business conclude
    [Arguments]    ${contractType}    ${product}    ${Customer}    ${destination}    ${origin}    ${seaFreight}
    # Create new request
    SeleniumLibrary.Wait Until Element Is Visible    ${btnAddNew}
    Wait Until Element Is Not Visible   ${loading}
    SeleniumLibrary.Click Element    ${btnAddNew}
    Wait Until Element Is Visible    ${modalContractType}
    Sleep    1s
    Run Keyword If    '${contractType}' == 'Basis'    SeleniumLibrary.Click Element    ${radioBasis}
    Run Keyword If    '${contractType}' == 'Flat'    SeleniumLibrary.Click ELement    ${radioFlat}
    SeleniumLibrary.Click Element    ${btnConfirm}
    SeleniumLibrary.Wait Until Element Is Visible    ${h4AddBusinessConclude}
    Wait Until Element Is Not Visible   ${loading}
    # Select item
    ${dataProduct}    Set Variable   xpath: //span[text()='${product}']/parent::div
    Select value from    ${ddlProduct}    ${dataProduct}
    Wait Until Element Is Not Visible   ${loading}
    # Select Plant Type
    SeleniumLibrary.Click Element    ${radioPlantType}
    Click Element    ${dateConclude} 
    Click Element    ${dataConcludeDate}    
        ## ----- For Flat -----
        Run Keyword If    '${contractType}' == 'Flat'    Input Text    ${inptPrice}    1000
        Run Keyword If    '${contractType}' == 'Flat'    Input Text    ${inptQTY}    50
        Run Keyword If    '${contractType}' == 'Flat'    Input Text    ${inptTorelance}    10
        ## ----- End -----

        ## ----- For Basis -----
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptBasis}    700
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptCBOT}    800
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptCNF}    900
        ## ----- End -----
    # Select Sea Freight
    Click Element    ${radioSeaFreight}

    # Select Payment
    Click Element    ${ddlPayment}
    Click Element    ${liPayment}
    Click Element    ${radioPaymentType}

    # Select Delivery
    Click Element    ${ddlTermOfDelivery}
    Click Element    ${liTermOfDelivery}

    # Shipment Period
    Click Element    ${dateShippingStart}
    Click Element    ${dataShippingStart}
    Click Element    ${dateShippingEnd}
    Click Element    ${dataShippingEnd}

    # Customer
    Set Focus To Element    ${ddlOriginCountry}
    # Click Element    ${ddlCustomer}
    # ${dataCustomer}    Set Variable    xpath: //ng-select[@placeholder='Input Buyer Name']//div[@role='option']/span[text()='${Customer}']
    # Click Element    ${dataCustomer}


