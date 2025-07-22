*** Settings ***
Library    SeleniumLibrary
Resource    ../keyword/globalKeyword.robot
Resource    ../variables/variableBusinessConclude.robot
Suite Setup    Open Samantra and login    ${urlSTG}    ${chrome}    ${EMPTY}    ${EMPTY}
Suite Teardown    Close All Browsers
Test Template    Create new business conclude

*** Variables ***

# ----- Date -----
${dataConcludeDate}     xpath: //ngb-datepicker-month//div[@aria-label='Monday, June 30, 2025']/div[text()=' 30 ']
${dataShippingStart}     xpath: //ngb-datepicker-month//div[@aria-label='Tuesday, July 1, 2025']/div[text()=' 1 ']
${dataShippingEnd}       xpath: //ngb-datepicker-month//div[@aria-label='Thursday, July 31, 2025']/div[text()=' 31 ']

# ----- Data in list -----
${dataCustomerAddress}    xpath: //ng-select[@placeholder='Input Buyer Address']//div[@role='option'][1]
${dataSupplier}    xpath: //ng-select[@placeholder='Input Seller Name']//div[@role='option']//span[text()='THANH KHOI']
${dataSupplierAddress}    xpath: //ng-select[@placeholder='Input Seller Address']//div[@role='option']
${dataOriginPort}    xpath: //label[text()='Origin Port ']//div[@role='option'][1]
${dataDestinationPort}    xpath: //label[text()='Destination Port ']//div[@role='option'][1]

*** Test Cases ***            Contract Type        Product                                              Customer                             Destination     Origin         SeaFreight
businessConclude_Flat         Flat                 U.S. SOLVENT EXTRACTED TOASTED SOYBEAN MEAL - USA    C.P. TRADING COMPANY LIMITED         Thailand        Brazil         Truck
businessConclude_Basis         Basis               U.S. SOLVENT EXTRACTED TOASTED SOYBEAN MEAL - USA    C.P. TRADING COMPANY LIMITED         Thailand        Brazil         Conventional Vessel

*** Keywords ***
Create new business conclude
    [Arguments]    ${contractType}    ${product}    ${Customer}    ${destination}    ${origin}    ${seaFreight}
    ${initFlag}=  Run Keyword And Return Status    Element Should Be Visible    ${h2Welcome}
    Run Keyword If    ${initFlag} == ${True}    Go to Business Conclude menu
    # Create new business
    SeleniumLibrary.Wait Until Element Is Visible    ${btnAddNew}
    Wait Until Element Is Not Visible   ${loading}    30s
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
    Wait Until Element Is Not Visible   ${loading}    30s
    # Select Plant Type
    SeleniumLibrary.Click Element    ${radioPlantType}
    Click Element    ${dateConclude} 
    Click Element    ${dataConcludeDate}    
        ## ----- For Flat -----
        Run Keyword If    '${contractType}' == 'Flat'    Input Text    ${inptPrice}    1000
        ## ----- End -----

        ## ----- For Basis -----
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptBasis}    125
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptCBOT}    700
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptCNF}    825
        Run Keyword If    '${contractType}' == 'Basis'    Input Text    ${inptCNFPrice}    940.5
        ## ----- End -----
    # Input QTY and Tolerance
    Input Text    ${inptQTY}    50
    Input Text    ${inptTorelance}    10

    # Select Sea Freight
    Click Element    ${radioSeaFreight}

    # Scroll down to half of them
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight/2)
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
    # Scroll down to bottom
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    # Select Customer
    Set Focus To Element    ${ddlCustomer}
    Click Element    ${ddlCustomer}
    ${dataCustomer}    Set Variable    xpath: //ng-select[@placeholder='Input Buyer Name']//div[@role='option']/span[text()='${Customer}']
    Click Element    ${dataCustomer}
    # Select Customer Address
    Set Focus To Element    ${ddlCustomerAddress}
    Click Element    ${ddlCustomerAddress}
    Wait Until Element Is Visible    ${dataCustomerAddress}    15s
    Click Element    ${dataCustomerAddress}

    # Supplier Customer
    Set Focus To Element    ${ddlSupplier}
    Click Element    ${ddlSupplier}
    Click Element    ${dataSupplier}
    # Select Supplier Address
    Set Focus To Element    ${ddlSupplierAddress}
    Click Element    ${ddlSupplierAddress}
    Wait Until Element Is Visible    ${dataSupplierAddress}    15s
    Click Element    ${dataSupplierAddress}

    # Origin 
    Set Focus To Element    ${ddlOriginCountry}
    Click Element    ${ddlOriginCountry}
    ${dataOriginCountry}    Set Variable    xpath: //div[@role='option']/span[text()='${origin}']
    Click Element    ${dataOriginCountry}
    # Select Origin Port
    Set Focus To Element    ${ddlOriginPort}
    Click Element    ${ddlOriginPort}
    Wait Until Element Is Visible    ${dataOriginPort}    15s
    Click Element    ${dataOriginPort}

    # Destination 
    Set Focus To Element    ${ddlDestinationCountry}
    Click Element    ${ddlDestinationCountry}
    ${dataDestinationCountry}    Set Variable    xpath: //div[@role='option']/span[text()='${destination}']
    Click Element    ${dataDestinationCountry}
    # Select Origin Port
    Set Focus To Element    ${ddlDestinationPort}
    Click Element    ${ddlDestinationPort}
    Wait Until Element Is Visible    ${dataDestinationPort}    15s
    Click Element    ${dataDestinationPort}

    # Submit Form
    Click Element    ${divFooter}
    Set Focus To Element    ${btnSubmitBC}
    Click Element    ${btnSubmitBC}
    # Wait until modal confirm show
    Wait Until Element Is Visible    ${modalConfirmTransaction}    15s
    Click Element    ${btnYes}

    # Wait until success
    Wait Until Element Is Visible    ${modalSuccess}    30s
    Click Element    ${btnOK}
    Wait Until Element Is Not Visible    ${loading}    30s


