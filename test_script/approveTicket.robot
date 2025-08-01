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
${env}    DEV
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
    [Arguments]    ${env}    ${requestID}    ${newPrice}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    # Click ปรับข้อมูล
    Wait Until Element Is Visible    ${btnAdjustData}    30s
    Set Focus To Element    ${btnAdjustData}
    Click Element    ${btnAdjustData}

    # Adjust data in the ปรับข้อมูล
    Wait Until Element Is Visible    ${h4AdjustData}
    Wait Until Element Is Visible    ${inptAdjustPrice}
    Set Focus To Element    ${inptAdjustPrice}
    Press Keys    ${inptAdjustPrice}    ${CTRLA}    ${newPrice}
    # Clik element to enable the save button
    Click Element    ${inptPurchaseTarget}
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

Create Request Ticket and approve tickets
    [Arguments]    ${RequestType}    ${ContractType}   ${price1}    ${price2}    ${price3}    ${price4}    ${price5}    ${price6}
    # Go to Create request
     Go to Request Ticket menu
    # Create new request ticket and get id
    ${requestID}=     Create new request ticket    ${env}    SBM    ${RequestType}    ${ContractType}    Viet Nam    BRA    Conventional Vessel
    # ${requestID}=    Set Variable    3334
    # Sleep    5s
    # Assign index for users list
    ${index}=    Set Variable    0
    # Assign price to list
    @{priceList}=    Create List
    # Verify price 1
        Run Keyword If    '${price1}' != '${EMPTY}'    Append To List    ${priceList}    ${price1}
    # If price is empty
        Run Keyword If    '${price1}' == '${EMPTY}'    Append To List    ${priceList}    ${EMPTY}
    # Verify price 2
        Run Keyword If    '${price2}' != '${EMPTY}'    Append To List    ${priceList}    ${price2}
    # If price is empty
        Run Keyword If    '${price2}' == '${EMPTY}'    Append To List    ${priceList}    ${EMPTY}
    # Verify price 3
        Run Keyword If    '${price3}' != '${EMPTY}'    Append To List    ${priceList}    ${price3}
    # If price is empty
        Run Keyword If    '${price3}' == '${EMPTY}'    Append To List    ${priceList}    ${EMPTY}
    # Verify price 4
        Run Keyword If    '${price4}' != '${EMPTY}'    Append To List    ${priceList}    ${price4}
    # If price is empty
        Run Keyword If    '${price4}' == '${EMPTY}'    Append To List    ${priceList}    ${EMPTY}
    # Verify price 5
        Run Keyword If    '${price5}' != '${EMPTY}'    Append To List    ${priceList}    ${price5}
    # If price is empty
        Run Keyword If    '${price5}' == '${EMPTY}'    Append To List    ${priceList}    ${EMPTY}
    # Verify price 6
        Run Keyword If    '${price6}' != '${EMPTY}'    Append To List    ${priceList}    ${price6}
    # If price is empty
        Run Keyword If    '${price6}' == '${EMPTY}'    Append To List    ${priceList}    ${EMPTY}

    Log To Console    Price list: @{priceList}
    FOR    ${price}    IN    @{priceList}
        ${approver}=    Evaluate    ${index} + 1
        #Log To Console    Current Approver: ${approver}
        IF    '${price}' != '${EMPTY}'
            # Re-login
            Logout and then login    ${liUsername}[${index}]    ${passApprover}
            # Approve with expected user
            Run Keyword If    '${RequestType}' == 'Total'   Go to tickets and submit comment - Total    ${env}    ${requestID}    ${price}    ${liUsername}[${index}]
            Run Keyword If    '${RequestType}' == 'Any'   Go to tickets and submit comment - Any    ${env}    ${requestID}    ${price}    ${liUsername}[${index}]
            Log To Console    Approved successfully.
        END
        ${index}=    Evaluate    ${index} + 1
    END


*** Test Cases ***      Request Type        Contract Type    Price 1       Price 2       Price 3       Price 4       Price 5        Price 6 (CEO)
Case 4-1                Total               Flat             800.758       800.231        780.881      780.881       801.758       801.758 
Case 4-2                Total               Basis             800.758       800.231        780.881      780.881        801.758       801.758
# Case 4-2                Total               Flat             100           100           100           100           ${EMPTY}       ${EMPTY}
# Case 4-3              Total           100           99            99            99            ${EMPTY}       ${EMPTY}
# Case 4-4              Total           100           99            98            98            ${EMPTY}       ${EMPTY} 
# Case 4-5              Total           96            ${EMPTY}      97            96            ${EMPTY}       99
# Case 4-6              Total           99            99            99            97            ${EMPTY}       98
# Case 4-7              Total           165           162           164           165           ${EMPTY}       ${EMPTY}
# Case 5-1              Total           285           280           281           281           280            ${EMPTY}
# Case 5-2              Total           250           250           245           240           240            ${EMPTY}
# Case 5-3              Total           250           250           250           240           240            ${EMPTY}
# Case 5-4              Total           99            99            99            95            94             ${EMPTY}
# Case 5-5              Total           77.4          77.6          80.5          71.3          70             ${EMPTY}
# Case 5-6              Total           68            68            68            ${EMPTY}      57             57
# Case 5-7              Total           70            75            72            ${EMPTY}      76             77
# Case 5-8              Total           99            98            97            96            95             ${EMPTY}
# Case 5-9              Total           50.55         51.39         51.2          50            55             ${EMPTY}
# Case 5-10             Total           77            77            77            ${EMPTY}      73             66
# Case 5-11             Total           77            77            78            78            ${EMPTY}       74
# Case 5-12             Total           165           162           164           165           164            ${EMPTY}
# Case 5-13             Total           280           280           280           260           250            ${EMPTY}           
# Case 6-1              Total           280           280           240           240           240            240
# Case 6-2              Total           250           240           240           210           210            210  
# Case 6-3              Total           250           240           240           230           220            210
# Case 6-4              Total           270           270           250           240           240            230
# Case 6-5              Total           99            99            99            95            94             93
# Case 6-6              Total           99            99            97            93            93             93
# Case 6-7              Total           Flat           888.25            98            97            96            94             94

Data preparation Flat 1        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Flat 2        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Flat 3        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Flat 4        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Flat 5        Total         Flat        800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Flat 6        Total         Flat        800.758          ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Basis 1        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Basis 2        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Basis 3        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Basis 4        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Basis 5        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}
Data preparation Basis 6        Total         Basis       800.758           ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}        ${EMPTY}