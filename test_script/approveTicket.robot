*** Settings ***
Library    String
Resource    ../keyword/globalKeyword.robot
Resource    ../keyword/keywordRequestTicket.robot
Resource    ../variables/variableApproveRequestTicket.robot
Suite Setup    Open Samantra and login    ${urlDev}    ${chrome}    ${EMPTY}    ${EMPTY}
#Suite Teardown    Close All Browsers

*** Variables ***
@{liUsername}    ['manao_executive01','manao_executive02','manao_executive03','manao_executive04','manao_executive05']
${passApprover}    123456
${newPrice}    525
*** Keywords ***
Go to Approval on that request ticket
    [Arguments]    ${requestID}
    #Set URL, need to change btw Dev or STG
    ${testURL}=    Set Variable    ${urlApproveDev}${requestID}
    Go To    ${testURL}
    Wait Until Element Is Visible    ${h2TicketApproval}

Go to tickets and submit comment
    [Arguments]    ${requestID}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${requestID}
    Wait Until Element Is Not Visible    ${loading}    30s
    Sleep    3s
    # Click ปรับข้อมูล
    Wait Until Element Is Visible    ${btnAdjustData}    30s
    Set Focus To Element    ${btnAdjustData}
    Click Element    ${btnAdjustData}

    # Adjust data in the ปรับข้อมูล
    Wait Until Element Is Visible    ${h4AdjustData}
    Wait Until Element Is Visible    ${inptAdjustPrice}
    Set Focus To Element    ${inptAdjustPrice}
    Press Keys    ${inptAdjustPrice}    ${CTRLA}    ${newPrice}
    Element Should Be Enabled    ${btnSave}
    Click Element    ${btnSave}
    Wait Until Element Is Not Visible    ${txtSuccess}    30s

    # Comment
    Set Focus To Element    ${inptComment}
    Input Text    ${inptComment}    Inputted by robot    ${username}
    
    # Click ส่งความเห็น
    Wait Until Element Is Enabled    ${btnSubmit}
    Set Focus To Element    ${btnSubmit}
    Press Keys    ${None}    ENTER

    # Click ยืนยัน
    Wait Until Element Is Visible    ${btnConfirm}
    Click Element    ${btnConfirm}

    Wait Until Element Is Not Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s

*** Test Cases ***
Create Request Ticket and approve tickets
    # Go to Create request
    # Go to Request Ticket menu
    # Create new request ticket and get id
    #${requestID}=     Create new request ticket    SBM    Basis    Thailand    BRA    Conventional Vessel
    ${requestID}=    Set Variable    2778
    Sleep    5s
    # Re-login
    Logout and then login    @{liUsername}[0]    ${passApprover}
    Sleep    3s

    Go to tickets and submit comment    ${requestID}    @{liUsername}[0]
