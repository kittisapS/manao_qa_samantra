*** Settings ***
Library    String
Library    OperatingSystem
Resource    ../keyword/globalKeyword.robot
Resource    ../variables/variableRequestTicket.robot

*** Keywords ***
Get request no
    Wait Until Element Is Not Visible    ${loading}
    Wait Until Element Is Visible    ${hRequestNo}
    ${rawText}=    Get Text    ${hRequestNo}
    ${trimmedText}=    Strip String    ${rawText}
    ${requestNo}=    Replace String    ${trimmedText}    เลขที่คำขอจัดซื้อ :    ${EMPTY}
    ${url}=    Get Location
    ${trimmedURL}=    Strip String    ${url}
    ${requestID}=    Replace String    ${trimmedURL}    https://samantra-dev.fitcp.com/globaltrade/request-ticket/proposaledit/    ${EMPTY}
    # Add to File
    Append To File    output.txt    ${requestID},\n
    Log To Console    Request No: ${requestNo}, ID: ${requestID}
    RETURN    ${requestID}

Create new request ticket
    [Arguments]    ${ingredient}    ${contractType}    ${destination}    ${origin}    ${seaFreight}
    # Create new request
    SeleniumLibrary.Wait Until Element Is Visible    ${btnCreateNewRequest}
    Wait Until Element Is Not Visible   ${loading}
    Wait Until Element Is Not Visible    ${txtSuccess}     
    Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${btnCreateNewRequest}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2NewRequestTicket}
    # Select Request  type
    Wait Until Element Is Visible    ${ddlRequestType}
    Click Element    ${ddlRequestType}
    Wait Until Element Is Visible    ${liTotal}
    Click Element    ${liTotal}
    # Select Contract Type
    ${dataContractType}    Set Variable    xpath: //div[@role='option']/span[contains(text(),'${contractType}')]
    Select value from    ${ddlContractType}    ${dataContractType}
    # Select item
    ${dataIngredient}    Set Variable   xpath: //div[@role='option']/span[text()='${ingredient}']
    Select value from    ${ddlIngredient}    ${dataIngredient}
    # Select Destination
    IF    '${destination}' == 'Lao People Democratic Republic'
        ${dataDestination}    Set Variable   xpath: //div[@role='option' and contains(text(),'Lao People')]
    ELSE
        ${dataDestination}    Set Variable   xpath: //div[@role='option' and text()=' ${destination} ']
    END
    Select value from    ${ddlDestination}    ${dataDestination}
    # Select Due date
    Select value from    ${dateDuedate}    ${date25}
    SeleniumLibrary.Click Element    ${dateDuedate}
    # Create request
    SeleniumLibrary.Click Element    ${btnCreateRequest}
    Wait Until Element Is Not Visible   ${loading}

    #Get Request No.
    ${requestID}=    Get request no

    # Click add new supplier
    SeleniumLibrary.Click Element    ${btnAddSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${txtSupplierFlat}
    # Click supplier
    SeleniumLibrary.Click Element    ${ddlSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${li1st}
    SeleniumLibrary.Click Element    ${li1st}
    # Input Spec.
    SeleniumLibrary.Input Text    ${inptSpec}    1000
    # Input MaxCapacity
    SeleniumLibrary.Input Text    ${inptMaxCapacity}    1000
    # Select Origin
    ${dataOrigin}    Set Variable      xpath: //span[text()='${origin}']//ancestor::div[@role='option']
    Select value from    ${ddlOrigin}    ${dataOrigin}
    # Select Product Origin
    ${dataProductOrigin}    Set Variable    xpath: //div[@role='option'][1]
    Select value from    ${ddlProductOrigin}    ${dataProductOrigin}
    # Select Port
    ${dataPort}    Set Variable       xpath: //div[@role='option' and text()=' ANY ']
    Select value from    ${ddlEndpoint}    ${dataPort}
    # Select Sea Frienght
    ${dataSeaFreight}    Set Variable        xpath: //span[text()='${seaFreight}']//ancestor::div[@role='option']
    Select value from    ${ddlSeaFrieght}    ${dataSeaFreight}
    # Select Package
    ${dataPackage}    Set Variable    xpath: //div[@role='option'][1]
    Select value from    ${ddlPackage}    ${dataPackage}
    # Shipping start (Fixed as 1 July 2025)
    SeleniumLibrary.Click Element    ${dateShippingStart}
    SeleniumLibrary.Click Element    ${dataShippingStart}
    # Shipping End (Fixed as 31 July 2025)
    SeleniumLibrary.Click Element    ${dateShippingEnd}
    SeleniumLibrary.Click Element    ${dataShippingEnd}
    # # Capture logical
    # BuiltIn.Sleep    3s
    # SeleniumLibrary.Capture Page Screenshot    RequestTicket_${TEST NAME}_${ingredient}_Origin${origin}_Destination${destination}_.png
    # ----- Case Basis -----
    # Select Contract
    ${dataContract}    Set Variable    xpath: //div[@role='option'][1]
    Run Keyword If    '${contractType}' == 'Basis'    Select value from    ${ddlContract}    ${dataContract}
    # Input Price
    Run Keyword If    '${contractType}' == 'Basis'    SeleniumLibrary.Input Text    ${inptBasis}    1000
    Run Keyword If    '${contractType}' == 'Basis'    SeleniumLibrary.Input Text    ${inptCBOT}    10000
    # Select Proteitn (Force as Basis + CBOT)
    Run Keyword If    '${contractType}' == 'Basis'    Select value from    ${ddlCalProtein}    xpath: //span[text()='Basis + CBOT']//ancestor::div[@role='option']
    # ----- End Basis -----

    # ----- Case Flat -----
    # Input Flat
    Run Keyword If    '${contractType}' == 'Flat'    SeleniumLibrary.Input Text    ${inptFlat}    1000
    # Input Factory
    Run Keyword If    '${contractType}' == 'Flat'    SeleniumLibrary.Input Text    ${inptTrasportFee}    25
    # Select Proteitn (Force as Flat)
    Run Keyword If    '${contractType}' == 'Flat'    Select value from    ${ddlCalProtein}    xpath: //span[text()='Total']//ancestor::div[@role='option']
 
    # Save supplier
    SeleniumLibrary.Click Element    ${btnSave}

    # ----- Create 2nd supplier -----
    # Click add new supplier
    SeleniumLibrary.Click Element    ${btnAddSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${txtSupplierFlat}
    Sleep    2s
    # Click supplier
    SeleniumLibrary.Click Element    ${ddlSupplier}
    ${dataSupplier}    Set Variable     xpath: //ng-dropdown-panel//div[2]/span
    SeleniumLibrary.Wait Until Element Is Visible    ${dataSupplier}
    SeleniumLibrary.Click Element    ${dataSupplier}
    # Save supplier
    SeleniumLibrary.Click Element    ${btnSave}

    # Input topic
    Set Focus To Element     ${inptTopic}
    Input Text    ${inptTopic}    Test001
    # Input additional info
    Set Focus To Element    ${inptAdditionalDetail}
    Input Text    ${inptAdditionalDetail}   Test001
    Set Focus To Element    ${btnSubmitRequest}
    Wait Until Element Is Visible    ${btnSubmitRequest}   30s
    Click Element    ${btnSubmitRequest}
    Wait Until Element Is Visible    ${btnConfirm}    30s
    Click Element    ${btnConfirm}
    Wait Until Element Is Not Visible   ${loading}    30s
    Wait Until Element Is Not Visible    ${txtSuccess}    30s

    RETURN    ${requestID}