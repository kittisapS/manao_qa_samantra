*** Settings ***
Library    String
Library    OperatingSystem
Library    DateTime
Resource    ../keyword/globalKeyword.robot
Resource    ../variables/variableRequestTicket.robot

*** Keywords ***
Get request no
    [Arguments]    ${env}  
    Wait Until Element Is Not Visible    ${loading}
    Wait Until Element Is Visible    ${hRequestNo}
    ${rawText}=    Get Text    ${hRequestNo}
    ${trimmedText}=    Strip String    ${rawText}
    ${requestNo}=    Replace String    ${trimmedText}    เลขที่คำขอจัดซื้อ :    ${EMPTY}
    ${url}=    Get Location
    ${trimmedURL}=    Strip String    ${url}
    # Validate if env == Dev
    IF    '${env}' == 'DEV'
             ${requestID}=    Replace String    ${trimmedURL}    https://samantra-dev.fitcp.com/globaltrade/request-ticket/proposaledit/    ${EMPTY}   
    END
    # Validate if env == STG
    IF    '${env}' == 'STG'
             ${requestID}=    Replace String    ${trimmedURL}    https://samantra-staging.fitcp.com/globaltrade/request-ticket/proposaledit/    ${EMPTY}   
    END

    # Add to File
    Append To File    output.txt    Doc No:${requestNo},ID: ${requestID},\n
    Log To Console    Request No: ${requestNo}, ID: ${requestID}
    RETURN    ${requestID}

Set ticket date
    # Get current date and time
    ${now}=    DateTime.Get Current Date
    ${currentYear}=    DateTime.Convert Date    ${now}    result_format=%Y
    ${currentMonth}=    DateTime.Convert Date    ${now}    result_format=%B
    ${currentDay}=    DateTime.Convert Date    ${now}    result_format=%A
    ${currentDate}=    DateTime.Convert Date    ${now}    result_format=%d
    ${currentDateNoPadding}=    Replace String Using Regexp    ${currentDate}    ^0    ${EMPTY}
    ${currentFulldate}=    BuiltIn.Set Variable    ${currentDay}, ${currentMonth} ${currentDateNoPadding}, ${currentYear}
    ${newTime}=    DateTime.Add Time To Date    ${now}    2 hours    result_format=%H
    # Convert time to usabled format
    ${expectedTime}=    BuiltIn.Set Variable    ${newTime}:00
    # Select Due date
    ${dataDate}=    BuiltIn.Set Variable    xpath: //ngb-datepicker-month//div[@aria-label='${currentFulldate}']/div[text()=' ${currentDateNoPadding} ']
    Select value from    ${dateDuedate}    ${dataDate}
    # Change the time
    SeleniumLibrary.Click Element    ${dateDuedate}
    SeleniumLibrary.Wait Until Element Is Visible    ${ddlTime}
    ${dataTime}=    BuiltIn.Set Variable    xpath: //ngb-datepicker//div[@role='option']/span[contains(text(),'${expectedTime}')]
    SeleniumLibrary.Click Element   ${ddlTime}
    SeleniumLibrary.Wait Until Element Is Visible    ${dataTime} 
    SeleniumLibrary.Click Element    ${dataTime}

Set Shipping date
    [Arguments]    ${increment}
    # Assign date based on today + increment
    ${now}=    DateTime.Get Current Date
    ${newDate}=    DateTime.Add Time To Date    ${now}    ${increment} days
    ${year}=    DateTime.Convert Date    ${newDate}    result_format=%Y
    ${month}=    DateTime.Convert Date    ${newDate}    result_format=%B
    ${day}=    DateTime.Convert Date    ${newDate}    result_format=%A
    ${date}=    DateTime.Convert Date    ${newDate}    result_format=%d
    ${dateNoPadding}=    Replace String Using Regexp    ${date}    ^0    ${EMPTY}
    ${fulldate}=    BuiltIn.Set Variable    ${day}, ${month} ${dateNoPadding}, ${year}
    ${dataShipping}=    BuiltIn.Set Variable       xpath: //ngb-datepicker-month//div[@aria-label='${fulldate}']/div[text()=' ${dateNoPadding} ']
    [Return]    ${dataShipping}

Create new request ticket
    [Arguments]    ${env}    ${ingredient}    ${requestType}    ${contractType}    ${destination}    ${origin}    ${seaFreight}
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
    Run Keyword If    '${requestType}' == 'Total'   Click Element    ${liTotal}
    Run Keyword If    '${requestType}' == 'Any'   Click Element    ${liAny}
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
    # Date and time of the ticket
    Set Ticket Date

    # Create request
    SeleniumLibrary.Click Element    ${btnCreateRequest}
    Wait Until Element Is Visible   ${loading}    10s
    Wait Until Element Is Not Visible   ${loading}    10s

    # Add info. to file
    Append To File    output.txt    Request Type: ${requestType}, Contract Type: ${contractType}, 
    #Get Request No. 
    ${requestID}=    Get request no    ${env}

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
    Run Keyword If    '${requestType}' == 'Total'   SeleniumLibrary.Input Text    ${inptMaxCapacity}    1000
    Run Keyword If    '${requestType}' == 'Any'     SeleniumLibrary.Input Text    ${inptQuantity}    1000
    # Select Origin
    ${dataOrigin}    Set Variable      xpath: //span[text()='${origin}']//ancestor::div[@role='option']
    Select value from    ${ddlOrigin}    ${dataOrigin}
    # Select Product Origin (Total)
    ${dataProductOrigin}    Set Variable    xpath: //div[@role='option'][1]
    Run Keyword If    '${requestType}' == 'Total'    Select value from    ${ddlProductOrigin}    ${dataProductOrigin}
    # Select Port
    ${dataPort}    Set Variable       xpath: //div[@role='option' and text()=' ANY ']
    Select value from    ${ddlEndpoint}    ${dataPort}
    # Select Sea Frienght
    ${dataSeaFreight}    Set Variable        xpath: //span[text()='${seaFreight}']//ancestor::div[@role='option']
    Select value from    ${ddlSeaFrieght}    ${dataSeaFreight}
    # Select Package (Total)
    ${dataPackage}    Set Variable    xpath: //div[@role='option'][1]
    Run Keyword If    '${requestType}' == 'Total'    Select value from    ${ddlPackage}    ${dataPackage}
    # Shipping start - end
    ${dataShippingStart}=    Set Shipping date    0
    ${dataShippingEnd}=    Set Shipping date    30
    SeleniumLibrary.Click Element    ${dateShippingStart}
    SeleniumLibrary.Click Element    ${dataShippingStart}
        # Shipping End 
    SeleniumLibrary.Click Element    ${dateShippingEnd}
    SeleniumLibrary.Click Element    ${dataShippingEnd}

    # ----- Case Basis -----
    # Select Contract (Total)
    ${dataContract}    Set Variable    xpath: //div[@role='option'][1]
    IF    '${requestType}' == 'Total'
        Run Keyword If    '${contractType}' == 'Basis'    Select value from    ${ddlContract}    ${dataContract}  
    END 
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
    Sleep    1s
    # Click supplier
    SeleniumLibrary.Click Element    ${ddlSupplier}
    ${dataSupplier}    Set Variable     xpath: //ng-dropdown-panel//div[5]/span
    SeleniumLibrary.Wait Until Element Is Visible    ${dataSupplier}
    SeleniumLibrary.Click Element    ${dataSupplier}
    # ----- Case Basis -----
    # Input Price
    Run Keyword If    '${contractType}' == 'Basis'    SeleniumLibrary.Input Text    ${inptBasis}    1250.30
    # ----- End Basis -----
    # ----- Case Flat -----
    # Input Flat
    Run Keyword If    '${contractType}' == 'Flat'    SeleniumLibrary.Input Text    ${inptFlat}    1250.30

    # Save supplier
    SeleniumLibrary.Click Element    ${btnSave}

    # ----- Create 3rd supplier -----
    # Click add new supplier
    SeleniumLibrary.Click Element    ${btnAddSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${txtSupplierFlat}
    Sleep    2s
    # Click supplier
    SeleniumLibrary.Click Element    ${ddlSupplier}
    ${dataSupplier}    Set Variable     xpath: //ng-dropdown-panel//div[8]/span
    SeleniumLibrary.Wait Until Element Is Visible    ${dataSupplier}
    SeleniumLibrary.Click Element    ${dataSupplier}
    # ----- Case Basis -----
    # Input Price
    Run Keyword If    '${contractType}' == 'Basis'    SeleniumLibrary.Input Text    ${inptBasis}    1500.40
    # ----- End Basis -----
    # ----- Case Flat -----
    # Input Flat
    Run Keyword If    '${contractType}' == 'Flat'    SeleniumLibrary.Input Text    ${inptFlat}    1500.40

    # Save supplier
    SeleniumLibrary.Click Element    ${btnSave}

    # ----- Create 4th supplier -----
    # Click add new supplier
    SeleniumLibrary.Click Element    ${btnAddSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${txtSupplierFlat}
    Sleep    2s
    # Click supplier
    SeleniumLibrary.Click Element    ${ddlSupplier}
    ${dataSupplier}    Set Variable     xpath: //ng-dropdown-panel//div[10]/span
    SeleniumLibrary.Wait Until Element Is Visible    ${dataSupplier}
    SeleniumLibrary.Click Element    ${dataSupplier}
    # ----- Case Basis -----
    # Input Price
    Run Keyword If    '${contractType}' == 'Basis'    SeleniumLibrary.Input Text    ${inptBasis}    1750.23
    # ----- End Basis -----
    # ----- Case Flat -----
    # Input Flat (USD)
    IF    '${contractType}' == 'Flat'
        # input Flat
        SeleniumLibrary.Input Text    ${inptFlat}    1750.23
        SeleniumLibrary.Input Text    ${inptTrasportFee}    45
    END
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
    Run Keyword If    '${requestType}' == 'Any'    Wait Until Element Is Visible    ${txtSuccess}    30s
    Run Keyword If    '${requestType}' == 'Any'    Wait Until Element Is Not Visible    ${txtSuccess}    30s
    Run Keyword If    '${requestType}' == 'Total'    Wait Until Element Is Visible    ${txtRequestSuccess}    30s
    Run Keyword If    '${requestType}' == 'Total'    Wait Until Element Is Not Visible    ${txtRequestSuccess}    30s
    RETURN    ${requestID}