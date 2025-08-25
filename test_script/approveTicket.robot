*** Settings ***
Library    String
Library    Collections
Resource    ../keyword/globalKeyword.robot
Resource    ../keyword/keywordRequestTicket.robot
Resource    ../variables/variableApproveRequestTicket.robot
Test Setup    Open Samantra and login    ${env}    ${chrome}    ${EMPTY}    ${EMPTY}
Test Template    Create Request Ticket and approve tickets
Test Teardown    Close All Browsers

*** Variables ***
@{liUsername}=    @{usernameSet4}
${passwordApprover}=    ${passwordApproverSet4}
${env}    DEV
${dataDestination}    Thailand

@{supplierQty}    100000    #20000    30000
@{supplierPrice}    123.45    #223.45    323.45
@{supplierShipment}    1,9,30,9    #2,8,29,8    3,7,28,7


*** Keywords ***
Set New QTY
    [Arguments]    ${qty}
    Wait Until Element Is Visible    ${inptAnyNewQTY}
    Set Focus To Element    ${inptAnyNewQTY}
    Press Keys    ${inptAnyNewQTY}    ${CTRLA}    ${qty}
    # Clik another element to enable the save button
    Click Element    ${inptAnyNewPriceHigh}

Set New Price
    [Arguments]    ${price}
    Wait Until Element Is Visible    ${inptAnyNewPriceHigh}
    Set Focus To Element    ${inptAnyNewPriceHigh}
    Press Keys    ${inptAnyNewPriceHigh}    ${CTRLA}    ${price}
    # Clik another element to enable the save button
    Click Element    ${inptAnyNewQTY}
    
Select New Start Shipment Date
    [Arguments]    ${day}    ${month} 
    Wait Until Element Is Visible    ${shipmentStartDateNew}
    Click Element    ${shipmentStartDateNew}
    Wait Until Element Is Visible    ${ddlSelectMonth}
    Click Element    ${ddlSelectMonth}
    Click Element    xpath: //select[@aria-label="Select month"]/option[@value="${month}"]
    Click Element    xpath: //div[@role="gridcell"]/div[contains(@class,"custom-day") and not(contains(@class,"text-muted")) and normalize-space(text())="${day}"]

Select New End Shipment Date
    [Arguments]    ${day}    ${month}
    Wait Until Element Is Visible    ${shipmentEndDateNew}
    Click Element    ${shipmentEndDateNew}
    Wait Until Element Is Visible    ${ddlSelectMonth}
    Click Element    ${ddlSelectMonth}
    Click Element    xpath: //select[@aria-label="Select month"]/option[@value="${month}"]
    Click Element    xpath: //div[@role="gridcell"]/div[contains(@class,"custom-day") and not(contains(@class,"text-muted")) and normalize-space(text())="${day}"]
    
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

Go to tickets and submit comment - Total
    [Arguments]    ${env}    ${requestID}    ${changeItem}    ${item}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    # Click ปรับข้อมูล
    Wait Until Element Is Visible    ${btnAdjustData}    30s
    Set Focus To Element    ${btnAdjustData}
    Click Element    ${btnAdjustData}
    Wait Until Element Is Visible    ${h4AdjustData}

    # --- Adjust data in the ปรับข้อมูล ---
    # Check which data should be changed
    IF    '${changeItem}' == 'Purchase'
        Wait Until Element Is Visible    ${inptPurchaseTarget}
        Set Focus To Element    ${inptPurchaseTarget}
        Press Keys    ${inptPurchaseTarget}    ${CTRLA}    ${item}
        # Clik another element to enable the save button
        Click Element    ${inptAdjustPrice}
    ELSE IF    '${changeItem}' == 'Price'
        Wait Until Element Is Visible    ${inptAdjustPrice}
        Set Focus To Element    ${inptAdjustPrice}
        Press Keys    ${inptAdjustPrice}    ${CTRLA}    ${item}
        # Clik another element to enable the save button
        Click Element    ${inptPurchaseTarget}
    END

    Element Should Be Enabled    ${btnSave}
    # Click Save button to confirm change
    Click Element    ${btnSave}
    Wait Until Element Is Visible    ${txtEditedSuccess}    30s
    Wait Until Element Is Not Visible    ${txtEditedSuccess}    30s

    # Comment
    Set Focus To Element    ${inptComment}
    Input Text    ${inptComment}    Inputted by robot ${username}
    
    # Click ส่งความเห็น
    Wait Until Element Is Enabled    ${btnSubmit}
    Set Focus To Element    ${btnSubmit}
    Press Keys    ${None}    ENTER

    # Click ยืนยัน
    Wait Until Element Is Visible    ${btnConfirm}
    Click Element    ${btnConfirm}

    Wait Until Element Is Not Visible    ${loading}    30s
    Wait Until Element Is Visible    ${txtCommentSuccess}    30s
    Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s

    # Wait for reloading page
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s

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

Go to tickets and submit comment - Any
    [Arguments]    ${env}    ${requestID}    ${changeItem}    ${item}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    # Select 1st checkbox
    Wait Until Element Is Visible    ${chkSupplier1}    30s
    Click Element    ${chkSupplier1}
    # Click ปรับข้อมูล
    Wait Until Element Is Visible    ${btnAdjustDataSupplier1}    30s
    Set Focus To Element    ${btnAdjustDataSupplier1}
    Click Element    ${btnAdjustDataSupplier1}

    # Adjust data in the ปรับข้อมูล
    Wait Until Element Is Visible    ${txtAnyAdjustPrice}
    Wait Until Element Is Visible    ${inptAnyNewPriceHigh}

    # Check which data should be changed
    IF    '${changeItem}' == 'QTY'
        Set New QTY    ${item}
    ELSE IF    '${changeItem}' == 'Price'
        Set New Price    ${item}
    ELSE IF    '${changeItem}' == 'Shipment'    #To set item: {dayStart},{monthStart},{dayEnd},{monthEnd}
        ${splittedDate}=    Split String    ${item}    ,
        Select New Start Shipment Date    ${splittedDate}[0]    ${splittedDate}[1]
        Select New End Shipment Date    ${splittedDate}[2]    ${splittedDate}[3]
    ELSE IF    '${changeItem}' == 'ShipmentEnd'     #To set item: {day},{month}
        ${splittedDate}=    Split String    ${item}    ,
        Select New End Shipment Date    ${splittedDate}[0]    ${splittedDate}[1]
    ELSE IF    '${changeItem}' == 'All'    #To set item: {QTY},{Price},{dayStart},{monthStart},{dayEnd},{monthEnd}
        ${arg}=    Split String    ${item}    ,
        ${qty}=    Get From List    ${arg}    0
        ${price}=    Get From List    ${arg}    1
        ${dayStart}=    Get From List    ${arg}    2
        ${monthStart}=    Get From List    ${arg}    3
        ${dayEnd}=    Get From List    ${arg}    4
        ${monthEnd}=    Get From List    ${arg}    5

        Set New QTY    ${qty}
        Set New Price    ${price}
        Select New Start Shipment Date    ${dayStart}    ${monthStart}
        Select New End Shipment Date    ${dayEnd}    ${monthEnd}
    END
    
    # Comment
    Set Focus To Element    ${inptComment}
    Input Text    ${inptComment}    Inputted by robot ${username}
    # Click Save button to confirm change
    Element Should Be Enabled    ${btnSave}
    Click Element    ${btnSave}
    Wait Until Element Is Visible    ${txtCommentSuccess}    30s
    Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s
    
    # Click ส่งความเห็น
    Wait Until Element Is Enabled    ${btnAnySubmit}
    Set Focus To Element    ${btnAnySubmit}
    Press Keys    ${None}    ENTER

    # Click ยืนยัน
    Wait Until Element Is Visible    ${btnConfirm}
    Click Element    ${btnConfirm}

    Wait Until Element Is Not Visible    ${loading}    30s
    Wait Until Element Is Visible    ${txtCommentSuccess}    30s
    Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s

    # Wait for reloading page
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s

Create Request Ticket and approve tickets
    [Arguments]    ${RequestType}    ${ContractType}    ${arrQty}    ${arrPrice}    ${arrShipment}    ${changeItem}   ${data1}    ${data2}    ${data3}    ${data4}    ${data5}    ${data6}
    # Go to Create request
    Sleep    1s
    Go to Request Ticket menu
    # Create new request ticket and get id
    ${requestID}=     Create new request ticket    ${env}    SBM    ${RequestType}    ${ContractType}    ${dataDestination}    BRA    Conventional Vessel    ${arrQty}    ${arrPrice}    ${arrShipment}
    # ${requestID}=    Set Variable    3334
    # Assign index for users list
    ${index}=    Set Variable    0
    # Assign price to list
    @{dataList}=    Create List
    # Verify Item 1
        Run Keyword If    '${data1}' != '${EMPTY}'    Append To List    ${dataList}    ${data1}
    # If Item is empty
        Run Keyword If    '${data1}' == '${EMPTY}'    Append To List    ${dataList}    ${EMPTY}
    # Verify Item 2
        Run Keyword If    '${data2}' != '${EMPTY}'    Append To List    ${dataList}    ${data2}
    # If Item is empty
        Run Keyword If    '${data2}' == '${EMPTY}'    Append To List    ${dataList}    ${EMPTY}
    # Verify Item 3
        Run Keyword If    '${data3}' != '${EMPTY}'    Append To List    ${dataList}    ${data3}
    # If Item is empty
        Run Keyword If    '${data3}' == '${EMPTY}'    Append To List    ${dataList}    ${EMPTY}
    # Verify Item 4
        Run Keyword If    '${data4}' != '${EMPTY}'    Append To List    ${dataList}    ${data4}
    # If Item is empty
        Run Keyword If    '${data4}' == '${EMPTY}'    Append To List    ${dataList}    ${EMPTY}
    # Verify Item 5
        Run Keyword If    '${data5}' != '${EMPTY}'    Append To List    ${dataList}    ${data5}
    # If Item is empty
        Run Keyword If    '${data5}' == '${EMPTY}'    Append To List    ${dataList}    ${EMPTY}
    # Verify Item 6
        Run Keyword If    '${data6}' != '${EMPTY}'    Append To List    ${dataList}    ${data6}
    # If Item is empty
        Run Keyword If    '${data6}' == '${EMPTY}'    Append To List    ${dataList}    ${EMPTY}

    Log To Console    Data list: @{dataList}
    FOR    ${item}    IN    @{dataList}
        ${approver}=    Evaluate    ${index} + 1
        #Log To Console    Current Approver: ${approver}
        IF    '${item}' != '${EMPTY}'
            # Re-login
            Logout and then login    ${liUsername}[${index}]    ${passwordApprover}
            # Approve with expected user
            IF    '${item}' == '${Reject}'
                Reject ticket    ${env}    ${requestID}    ${liUsername}[${index}]
            ELSE
                Run Keyword If    '${RequestType}' == 'Total'   Go to tickets and submit comment - Total    ${env}    ${requestID}    ${changeItem}    ${item}    ${liUsername}[${index}]
                Run Keyword If    '${RequestType}' == 'Any'   Go to tickets and submit comment - Any    ${env}    ${requestID}    ${changeItem}    ${item}    ${liUsername}[${index}]
                Log To Console    Approved successfully.
            END
        END
        ${index}=    Evaluate    ${index} + 1
    END


*** Test Cases ***      Request Type        Contract Type        arrQty        arrPrice        arrShipment         ChangeItem       Item 1                       Item 2                       Item 3                       Item 4                       Item 5                       Item 6 (CEO)
# --------- Use these cases to prepare the test data ---------
Data preparation Flat 39        Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       100000,123.45,1,9,30,9       30000,121.45,1,9,15,9        20000,121.45,1,9,15,10    #Example for E2E Any Case39
Data preparation Flat 58        Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           3000,142.45,1,9,30,9         100000,142.45,1,9,30,9       100000,122.55,1,9,30,9       20000,112.55,1,9,30,9        ${EMPTY}                     ${EMPTY}    #Example for E2E Any Case58
Data preparation Basis 31       Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       100000,123.45,1,9,30,9       30000,121.45,1,9,15,9        20000,121.45,1,9,15,10    #Example for E2E Any Case31
Data preparation Basis 1        Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}    #Example for Create Any, no approve action
