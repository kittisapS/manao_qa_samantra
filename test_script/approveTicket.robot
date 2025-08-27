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
${env}    STG
${dataDestination}    Thailand

@{supplierQty}    100000    100000    #30000
@{supplierPrice}    123.45    123.45    #323.45
@{supplierShipment}    1,9,30,9    1,9,30,9    #3,7,28,7


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
            SeleniumLibrary.Close All Browsers
            SeleniumLibrary.Open Browser    ${urlSTG}   ${chrome}
            Login   ${liUsername}[${index}]    ${passwordApprover}
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
# Data Approve 6/6 Flat 39                Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       100000,123.45,1,9,30,9       30000,121.45,1,9,15,9        20000,121.45,1,9,15,9    #Example for E2E Any Case39
# Data Approve 5/6 Flat 40                Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       100000,121.45,1,9,30,9       30000,121.45,1,9,15,9        ${EMPTY}                  
# Data Approve 4/6 Flat 41                Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       20000,121.45,1,9,30,9        ${EMPTY}                     ${EMPTY}
# Data Approve 6/6 with CEO Flat 42       Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,25,9       100000,112.55,1,9,15,9       30000,102.45,1,9,15,9        100000,132.45,1,9,30,9        #ceo
# Data Approve 5/6 with CEO Flat 43       Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,25,9       20000,112.55,1,9,15,9        ${EMPTY}                     100000,132.55,1,9,30,9        #ceo                     
# Data Approve 4/6 with CEO Flat 44       Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,25,9       20000,132.55,1,9,30,9        ${EMPTY}                     ${EMPTY}                     100000,112.55,1,9,30,9        #ceo                     
# Data Approve from CEO 6/6 Flat 45       Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,130.55,1,9,15,9        30000,102.45,1,9,15,9        30000,102.45,1,9,15,9
# Data CEO 6/6 Flat 46                    Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        20000,122.34,1,9,15,9
# Data Resubmit 6/6 Flat 54               Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       30000,123.45,1,9,30,9        20000,122.55,1,9,30,9        100000,121.45,1,9,30,9       100000,121.45,1,9,30,9        
Data Resubmit 5/6 Flat 55               Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       30000,122.45,1,9,30,9        20000,120.45,1,9,30,9        100000,120.45,1,9,30,9       ${EMPTY}
Data Resubmit 4/6 Flat 56               Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       30000,122.45,1,9,30,9        100000,120.45,1,9,30,9       ${EMPTY}                     ${EMPTY}
# Data Resubmit 6/6 with CEO Flat 47      Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       20000,122.55,1,9,30,9        30000,102.45,1,9,15,9        100000,102.45,1,9,30,9    #ceo
# Data Resubmit 5/6 with CEO Flat 48      Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,25,9       100000,122.55,1,9,30,9       20000,112.55,1,9,15,9        ${EMPTY}                     100000,102.45,1,9,30,9    #ceo    
# Data Resubmit 4/6 with CEO Flat 49      Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,25,9       100000,122.55,1,9,30,9       ${EMPTY}                     ${EMPTY}                     100000,102.45,1,9,30,9    #ceo
# Data Resubmit from CEO 6/6 Flat 60      Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        30000,122.34,1,9,15,9
# Data Reject 6/6 with CEO Flat 65        Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        20000,102.45,1,9,15,9    #ceo
# Data Reject 5/6 with CEO Flat 66        Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        ${EMPTY}                     20000,102.45,1,9,15,9    #ceo
# Data Reject 4/6 with CEO Flat 67        Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       ${EMPTY}                     ${EMPTY}                     20000,102.45,1,9,15,9    #ceo
# Data Reject from CEO 6/6 Flat 68        Any    Flat    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        20000,122.34,1,9,15,9

# Basis
# Data Approve 6/6 Basis 39                Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       100000,123.45,1,9,30,9       30000,121.45,1,9,15,9        20000,121.45,1,9,15,9    #Example for E2E Any Case39
# Data Approve 5/6 Basis 40                Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       100000,121.45,1,9,30,9       30000,121.45,1,9,15,9        ${EMPTY}                  
# Data Approve 4/6 Basis 41                Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,123.45,1,9,30,9       20000,121.45,1,9,30,9        ${EMPTY}                     ${EMPTY}
# Data Approve 6/6 with CEO Basis 42       Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,25,9       100000,112.55,1,9,15,9       30000,102.45,1,9,15,9        100000,132.45,1,9,30,9        #ceo
# Data Approve 5/6 with CEO Basis 43       Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,25,9       20000,112.55,1,9,15,9        ${EMPTY}                     100000,132.55,1,9,30,9        #ceo                     
# Data Approve 4/6 with CEO Basis 44       Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,25,9       20000,132.55,1,9,30,9        ${EMPTY}                     ${EMPTY}                     100000,112.55,1,9,30,9        #ceo                     
# Data Approve from CEO 6/6 Basis 45       Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,130.55,1,9,15,9        30000,102.45,1,9,15,9        30000,102.45,1,9,15,9
# Data CEO 6/6 Basis 46                    Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        20000,122.34,1,9,15,9
# Data Resubmit 6/6 Basis 54               Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       30000,123.45,1,9,30,9        20000,122.55,1,9,30,9        100000,121.45,1,9,30,9       100000,121.45,1,9,30,9        
# Data Resubmit 5/6 Basis 55               Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       30000,122.45,1,9,30,9        20000,120.45,1,9,30,9        100000,120.45,1,9,30,9       ${EMPTY}
# Data Resubmit 4/6 Basis 56               Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       30000,122.45,1,9,30,9        100000,120.45,1,9,30,9       ${EMPTY}                     ${EMPTY}
# Data Resubmit 6/6 with CEO Basis 47      Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       20000,122.55,1,9,30,9        30000,102.45,1,9,15,9        100000,102.45,1,9,30,9    #ceo
# Data Resubmit 5/6 with CEO Basis 48      Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,25,9       100000,122.55,1,9,30,9       20000,112.55,1,9,15,9        ${EMPTY}                     100000,102.45,1,9,30,9    #ceo    
# Data Resubmit 4/6 with CEO Basis 49      Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,25,9       100000,122.55,1,9,30,9       ${EMPTY}                     ${EMPTY}                     100000,102.45,1,9,30,9    #ceo
# Data Resubmit from CEO 6/6 Basis 60      Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           100000,142.45,1,9,30,9       100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        30000,122.34,1,9,15,9
# Data Reject 6/6 with CEO Basis 65        Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        20000,102.45,1,9,15,9    #ceo
# Data Reject 5/6 with CEO Basis 66        Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        ${EMPTY}                     20000,102.45,1,9,15,9    #ceo
# Data Reject 4/6 with CEO Basis 67        Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       ${EMPTY}                     ${EMPTY}                     20000,102.45,1,9,15,9    #ceo
# Data Reject from CEO 6/6 Basis 68        Any    Basis    ${supplierQty}    ${supplierPrice}    ${supplierShipment}      All           30000,142.45,1,9,30,9        100000,142.45,1,9,30,9       100000,132.55,1,9,30,9       30000,112.55,1,9,15,9        30000,102.45,1,9,15,9        20000,122.34,1,9,15,9

# Data preparation Basis 1        Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}    #Example for Create Any, no approve action
# Data preparation Basis 2        Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}    #Example for Create Any, no approve action
# Data preparation Basis 3        Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}    #Example for Create Any, no approve action
# Data preparation Basis 4        Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}    #Example for Create Any, no approve action
# Data preparation Basis 5        Any    Basis   ${supplierQty}    ${supplierPrice}    ${supplierShipment}              All           ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}                     ${EMPTY}    #Example for Create Any, no approve action
