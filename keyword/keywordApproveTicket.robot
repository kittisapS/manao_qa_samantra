*** Settings ***
Library    DateTime
Library    String
Resource    ../keyword/globalKeyword.robot
Resource    ../variables/variableRequestTicket.robot
Resource    ../variables/variableApproveRequestTicket.robot

*** Keywords ***
Go to Approval on that request ticket
    [Arguments]    ${env}    ${requestID}
    #Set URL, need to change btw Dev or STG
    IF    '${env}' == 'DEV'    
        ${testURL}=    Set Variable    ${urlApproveDev}${requestID}
    ELSE IF    '${env}' == 'STG'    
        ${testURL}=    Set Variable    ${urlApproveSTG}${requestID}
    ELSE
        Log To Console    Please specify environment.
    END
    Go To    ${testURL}
    Wait Until Element Is Visible    ${h2TicketApproval}

Reject ticket
    [Arguments]    ${env}    ${requestID}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    # Scroll down to bottom
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    # Click ปรับข้อมูล
    Wait Until Element Is Visible    ${btnRejectTicket}    30s
    Set Focus To Element    ${btnRejectTicket}
    Click Element    ${btnRejectTicket}
    # Click ยืนยัน to input reject reason
    Wait Until Element Is Visible    ${btnConfirm}    30s
    Click Element    ${btnConfirm}
    # Wait and input the reason for reject
    Wait Until Element Is Visible    ${inptRejectComment}    30s
    Element Should Be Disabled    ${btnConfirmReject}
    Set Focus To Element    ${inptRejectComment}
    Input Text    ${inptRejectComment}    Rejected by robot ${username}
    Element Should Be Enabled    ${btnConfirmReject}
    Click Element    ${btnConfirmReject}

    # Wait until successfully reject
    Wait Until Element Is Not Visible    ${loading}    30s
    Wait Until Element Is Visible    ${txtCommentSuccess}    30s
    Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s

    # Wait for reloading page
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s

Set new shipping date
    [Arguments]    ${shipment}    ${data}
    # Assign date based on today + increment
    ${now}=    DateTime.Get Current Date
    ${year}=    DateTime.Convert Date    ${now}    result_format=%Y
    ${month}=    DateTime.Convert Date    ${now}    result_format=%m
    ${formattedMonth}=    DateTime.Convert Date    ${now}    result_format=%B
    ${dateInputted}=        BuiltIn.Set Variable    ${data}
    ${expectedDate}=        Replace String Using Regexp    ${dateInputted}    ^0    ${EMPTY}
    ${dateToConverted}=    Convert Date    ${year}-${month}-${data}
    ${dayOfWeek}=    DateTime.Convert Date    ${dateToConverted}    result_format=%A
    # Set date as full format
    ${fulldate}=    BuiltIn.Set Variable    ${dayOfWeek}, ${formattedMonth} ${expectedDate}, ${year}
    # Set datepicker variables
    ${dataShipping}=    BuiltIn.Set Variable       xpath: //ngb-datepicker-month//div[@aria-label='${fulldate}']/div[text()=' ${expectedDate} ']
    Log To Console    Full date: ${fulldate}
    Log To Console    Expected data: ${expectedDate}

    IF    '${shipment}' == 'start'
        # Check if shipments from any suppliers are shown.
        ${isSupplier1}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentStart1}
        ${isSupplier2}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentStart2}
        ${isSupplier3}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentStart3}
        ${isSupplier4}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentStart4}
        # If which one shown -> Assigned new value to them
        IF    '${isSupplier1}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentStart1}
            SeleniumLibrary.Click Element    ${shipmentStart1}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
        IF    '${isSupplier2}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentStart2}
            SeleniumLibrary.Click Element    ${shipmentStart2}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
        IF    '${isSupplier3}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentStart3}
            SeleniumLibrary.Click Element    ${shipmentStart3}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
        IF    '${isSupplier4}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentStart4}
            SeleniumLibrary.Click Element    ${shipmentStart4}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
    END
    IF    '${shipment}' == 'end'
        Log To Console    Start Execute end date adjustment
        ${isSupplier1}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentEnd1}
        ${isSupplier2}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentEnd2}
        ${isSupplier3}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentEnd3}
        ${isSupplier4}=    BuiltIn.Run Keyword And Return Status    Element Should Be Visible    ${shipmentEnd4}
        IF    '${isSupplier1}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentEnd1}
            SeleniumLibrary.Click Element    ${shipmentEnd1}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
        IF    '${isSupplier2}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentEnd2}
            SeleniumLibrary.Click Element    ${shipmentEnd2}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
        IF    '${isSupplier3}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentEnd3}
            SeleniumLibrary.Click Element    ${shipmentEnd3}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
        IF    '${isSupplier4}' == '${TRUE}'
            SeleniumLibrary.Set Focus To Element    ${shipmentEnd4}
            SeleniumLibrary.Click Element    ${shipmentEnd4}
            SeleniumLibrary.Wait Until Element Is Visible    ${dataShipping}
            SeleniumLibrary.Click Element    ${dataShipping}
        END
    END
    