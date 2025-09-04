*** Settings ***
Library    String
Library    Collections
Resource    ../keyword/globalKeyword.robot
Resource    ../keyword/keywordRequestTicket.robot
Resource    ../keyword/keywordApproveTicket.robot
Test Setup    Open Samantra and login    ${env}    ${chrome}    Manao_peepo    Manao100%
Test Template    Create Request Ticket and approve tickets
Test Teardown    Close All Browsers

*** Variables ***
${productShortName}    SBM
${env}    DEV
${dataDestination}    Thailand
${dataOrigin}    BRA
${dataSeaFreight}    Conventional Vessel

# Data Set for approver, please following these sample
# assigned list        Username                     Password    Purchase    Price       Shipment start    Shipment end    isReject
@{dataApprovalSet1}    manaoAutomate_executive01    Qa123456    2000        3000        15                25             ${False}
@{dataApprovalSet2}    manaoAutomate_executive02    Qa123456    1500        1750        ${EMPTY}          ${EMPTY}        ${True}
@{dataApprovalSet3}    manaoAutomate_executive03    Qa123456    2000        3000        15                25             ${False}
@{dataApprovalSet4}    manaoAutomate_executive04    Qa123456    1500        1750        ${EMPTY}          ${EMPTY}        ${False}
@{dataApprovalSet5}    manaoAutomate_executive05    Qa123456    2000        3000        15                25             ${False}
@{dataApprovalSetCEO}  manaoAutomate_ceo            Qa123456    ${EMPTY}    ${EMPTY}    ${EMPTY}      ${EMPTY}       ${True}

*** Keywords ***
Go to tickets and submit comment - Total
    [Arguments]    ${env}    ${requestID}    ${item}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    # Check if the ticket should be adjusted
    IF    '${item}[6]' == '${False}'
        # Click ปรับข้อมูล
        Wait Until Element Is Visible    ${btnAdjustData}    30s
        Set Focus To Element    ${btnAdjustData}
        Click Element    ${btnAdjustData}
        Wait Until Element Is Visible    ${h4AdjustData}

        # --- Adjust data in the ปรับข้อมูล ---
        # Check which data should be changed
        # Change the Purchase target
        IF    '${item}[2]' != '${EMPTY}'
            Wait Until Element Is Visible    ${inptPurchaseTarget}
            Set Focus To Element    ${inptPurchaseTarget}
            Press Keys    ${inptPurchaseTarget}    ${CTRLA}    ${item}[2]
            Sleep    0.5s
            # Clik another element to enable the save button
            Click Element    ${inptAdjustPrice}
        END
        # Change the Price
        IF    '${item}[3]' != '${EMPTY}'
            Wait Until Element Is Visible    ${inptAdjustPrice}
            Set Focus To Element    ${inptAdjustPrice}
            Press Keys    ${inptAdjustPrice}    ${CTRLA}    ${item}[3]
            Sleep    0.5s
            # Clik another element to enable the save button
            Click Element    ${inptPurchaseTarget}
        END
        # Change the Shipment Start
        IF    '${item}[4]' != '${EMPTY}'
            Set new shipping date    start    ${item}[4]
        END
        # Change the Shipment End
        IF    '${item}[5]' != '${EMPTY}'
            Set new shipping date    end    ${item}[5]
        END
        # Check if the ticket should be rejected

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
    # Check if the ticket should be rejected.
    ELSE
        Reject ticket    ${env}    ${requestID}    ${username}
    END


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
    [Arguments]    ${RequestType}    ${ContractType}   ${isApproval}
    # Go to Create request
    Sleep    1s
    Go to Request Ticket menu
    # Create new request ticket and get id
    ${requestID}=     Create new request ticket    ${env}    ${productShortName}    ${RequestType}    ${ContractType}    ${dataDestination}    ${dataOrigin}    ${dataSeaFreight}
    #${requestID}=    Set Variable    4241
    # Assign index for users list
    ${index}=    Set Variable    0
    IF    '${isApproval}' == '${True}'
    ${dataMatrix}=    Create List    ${dataApprovalSet1}    ${dataApprovalSet2}    ${dataApprovalSet3}    ${dataApprovalSet4}    ${dataApprovalSet5}    ${dataApprovalSetCEO}
        FOR    ${dataSet}    IN    @{dataMatrix}
            Log To Console    Data Matrix: ${dataMatrix}
            Log To Console    Data Set: ${dataSet}
            # Check if list is empty
            ${listLength}=    Get Length    ${dataSet}
            # Execute if those list is not empty
            IF    ${listLength} == 0 
                Log To Console    Skipped this approver ${index}
            ELSE
                    Log To Console    Current Approver: ${dataSet}[0]
                    # Re-login
                    Logout and then login    ${dataSet}[0]   ${dataSet}[1]
                    # Approve with expected user
                    Run Keyword If    '${RequestType}' == 'Total'   Go to tickets and submit comment - Total    ${env}    ${requestID}    ${dataSet}    ${dataSet}[0]
                    # Run Keyword If    '${RequestType}' == 'Any'   Go to tickets and submit comment - Any    ${env}    ${requestID}    ${item}    ${liUsername}[${index}]
                    Log To Console    Approved successfully.   
            END
            ${index}=    Evaluate    ${index} + 1
        END
    END

*** Test Cases ***      Request Type        Contract Type          Is Approval
# --------- Use these cases to prepare the test data ---------
Data preparation Flat 1        Total         Flat                  ${False}
Data preparation Basis 1        Total         Basis                  ${False}
Data preparation Flat 2        Total         Flat                  ${TRUE}
Data preparation Basis 2        Total         Basis                  ${TRUE}