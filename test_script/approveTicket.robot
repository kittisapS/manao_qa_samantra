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
@{liUsername}    manao_executive01  manao_executive02   manao_executive03   manao_executive04   manao_executive05   manao_ceo02
${passApprover}    123456
${env}    STG
${dataDestination}    Thailand

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
    [Arguments]    ${env}    ${requestID}    ${newPrice}    ${username}
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
    Set Focus To Element    ${inptAnyNewPriceHigh}
    Press Keys    ${inptAnyNewPriceHigh}    ${CTRLA}    ${newPrice}
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
    [Arguments]    ${RequestType}    ${ContractType}    ${changeItem}   ${data1}    ${data2}    ${data3}    ${data4}    ${data5}    ${data6}
    # Go to Create request
    Sleep    1s
    Go to Request Ticket menu
    # Create new request ticket and get id
    ${requestID}=     Create new request ticket    ${env}    SBM    ${RequestType}    ${ContractType}    ${dataDestination}    BRA    Conventional Vessel
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
            Logout and then login    ${liUsername}[${index}]    ${passApprover}
            # Approve with expected user
            IF    '${item}' == '${Reject}'
                Reject ticket    ${env}    ${requestID}    ${liUsername}[${index}]
            ELSE
                Run Keyword If    '${RequestType}' == 'Total'   Go to tickets and submit comment - Total    ${env}    ${requestID}    ${changeItem}    ${item}    ${liUsername}[${index}]
                Run Keyword If    '${RequestType}' == 'Any'   Go to tickets and submit comment - Any    ${env}    ${requestID}    ${item}    ${liUsername}[${index}]
                Log To Console    Approved successfully.
            END
        END
        ${index}=    Evaluate    ${index} + 1
    END


*** Test Cases ***      Request Type        Contract Type         ChangeItem       Item 1       Item 2       Item 3       Item 4       Item 5        Item 6 (CEO)
# --------- Use these cases to prepare the test data ---------
Data preparation Flat 1        Total         Flat        Purchase        1000           2000        1700        ${Reject}        ${Reject}        ${Reject}
Data preparation Flat 2        Total         Flat        Price        800.758           800.231        780.881        ${Reject}        ${Reject}        ${Reject}
# Data preparation Flat 3        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Flat 4        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Flat 5        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Flat 6        Total         Flat        800.758          ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Basis 1        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Basis 2        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Basis 3        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Basis 4        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Basis 5        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
# Data preparation Basis 6        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}

# --------- Use these cases to test the price compare logic ---------
# Case 4-1                Total               Flat        Price             800.758       800.231        780.881      780.881       801.758       801.758 
# Case 4-2                Total               Basis       Price             800.758       800.231        780.881      780.881        801.758       801.758
# Case 4-2                Total               Flat        Price             100           100           100           100           ${EMPTY}       ${EMPTY}
# Case 4-3              Total           Basis       Price     100           99            99            99            ${EMPTY}       ${EMPTY}
# Case 4-4              Total           Flat        Price    100           99            98            98            ${EMPTY}       ${EMPTY} 
# Case 4-5              Total           Basis       Price           96            ${EMPTY}      97            96            ${EMPTY}       99
# Case 4-6              Total           Flat        Price    99            99            99            97            ${EMPTY}       98
# Case 4-7              Total           Basis       Price           165           162           164           165           ${EMPTY}       ${EMPTY}
# Case 5-1              Total           Flat        Price    285           280           281           281           280            ${EMPTY}
# Case 5-2              Total           Basis       Price           250           250           245           240           240            ${EMPTY}
# Case 5-3              Total           Flat        Price    250           250           250           240           240            ${EMPTY}
# Case 5-4              Total           Basis       Price           99            99            99            95            94             ${EMPTY}
# Case 5-5              Total           Flat        Price    77.4          77.6          80.5          71.3          70             ${EMPTY}
# Case 5-6              Total           Basis       Price           68            68            68            ${EMPTY}      57             57
# Case 5-7              Total           Flat        Price    70            75            72            ${EMPTY}      76             77
# Case 5-8              Total           Basis       Price           99            98            97            96            95             ${EMPTY}
# Case 5-9              Total           Flat        Price    50.55         51.39         51.2          50            55             ${EMPTY}
# Case 5-10             Total           Basis       Price           77            77            77            ${EMPTY}      73             66
# Case 5-11             Total           Flat        Price    77            77            78            78            ${EMPTY}       74
# Case 5-12             Total           Basis       Price           165           162           164           165           164            ${EMPTY}
# Case 5-13             Total           Flat        Price    280           280           280           260           250            ${EMPTY}           
# Case 6-1              Total           Basis       Price           280           280           240           240           240            240
# Case 6-2              Total           Flat        Price    250           240           240           210           210            210  
# Case 6-3              Total           Basis       Price           250           240           240           230           220            210
# Case 6-4              Total           Flat        Price    270           270           250           240           240            230
# Case 6-5              Total           Basis       Price           99            99            99            95            94             93
# Case 6-6              Total           Flat        Price    99            99            97            93            93             93
# Case 6-7              Total           Basis       Price           888.25            98            97            96            94             94