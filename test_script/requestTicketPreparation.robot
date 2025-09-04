*** Settings ***
Library    String
Library    Collections
Resource    ../keyword/globalKeyword.robot
Resource    ../keyword/keywordRequestTicket.robot
Resource    ../keyword/keywordApproveTicket.robot
Test Setup    Open Samantra and login    ${env}    ${chrome}    ${EMPTY}    ${EMPTY}
Test Template    Create Request Ticket and approve tickets
Test Teardown    Close All Browsers

*** Variables ***
${productShortName}    SBM
${env}    DEV
${dataDestination}    Thailand
${dataOrigin}    BRA
${dataSeaFreight}    Conventional Vessel

# Data Set for approver, please following these sample
# assigned list        Username                     Password    Deselect Supplier    Purchase    Price     Shipment start    Shipment end        isReject
#                                                               (1-3)                (Numeric)   (Numeric)   (Should be 02-30)     (Cannot be 30)      (True/False)
@{dataApprovalSet1}    executive-01            123456            1                    3000        3000.25        15                25                 ${False}
@{dataApprovalSet2}    executive-02            123456            2                    2000        1750.75        02              ${EMPTY}              ${False}
@{dataApprovalSet3}    executive-03            123456            3                    1000        2578.32        15                25                 ${False}
@{dataApprovalSet4}    executive-04            123456            ${EMPTY}             2000        1750        ${EMPTY}          18                ${False}
@{dataApprovalSet5}    executive-05            123456            ${EMPTY}             2000        3813.24        15                25                 ${False}
@{dataApprovalSetCEO}  ceo-01                  123456            ${EMPTY}            ${EMPTY}    ${EMPTY}      ${EMPTY}               ${True}

*** Keywords ***
Go to tickets and submit comment - Total
    [Arguments]    ${env}    ${requestID}    ${item}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    SeleniumLibrary.Wait Until Element Is Visible    ${loading}    30s
    SeleniumLibrary.Wait Until Element Is Not Visible    ${loading}    30s
    # Check if the ticket should be adjusted
    IF    '${item}[7]' == '${False}'
        # Check if the suppliers is going to be deselected
        SeleniumLibrary.Wait Until Element Is Visible    ${chkTotalSupplier1}
        # If 1 supplier is not selected
        IF    '${item}[2]' == '1'  
            # Deselect supplier 4th        
            SeleniumLibrary.Set Focus To Element    ${chkTotalSupplier4}
            SeleniumLibrary.Click Element    ${chkTotalSupplier4}
        # If 2 suppliers are not selected
        ELSE IF    '${item}[2]' == '2'
            # Deselect supplier 4th
            SeleniumLibrary.Set Focus To Element    ${chkTotalSupplier4}
            SeleniumLibrary.Click Element    ${chkTotalSupplier4}
            # Deselect supplier 3rd
            SeleniumLibrary.Set Focus To Element    ${chkTotalSupplier3}
            SeleniumLibrary.Click Element    ${chkTotalSupplier3}
        ELSE IF    '${item}[2]' == '3'
            # Deselect supplier 4th
            SeleniumLibrary.Set Focus To Element    ${chkTotalSupplier4}
            SeleniumLibrary.Click Element    ${chkTotalSupplier4}
            # Deselect supplier 3rd
            SeleniumLibrary.Set Focus To Element    ${chkTotalSupplier3}
            SeleniumLibrary.Click Element    ${chkTotalSupplier3}
            # Deselect supplier 2nd
            SeleniumLibrary.Set Focus To Element    ${chkTotalSupplier2}
            SeleniumLibrary.Click Element    ${chkTotalSupplier2}
        ELSE
            Log To Console    No changed to suppliers or the value is incorrectly inputted (please input 1-3)
        END
        # Click ปรับข้อมูล
        SeleniumLibrary.Wait Until Element Is Visible    ${btnAdjustData}    30s
        SeleniumLibrary.Set Focus To Element    ${btnAdjustData}
        SeleniumLibrary.Click Element    ${btnAdjustData}
        SeleniumLibrary.Wait Until Element Is Visible    ${h4AdjustData}
        # --- Adjust data in the ปรับข้อมูล ---
        # Check which data should be changed
        # Change the Purchase target
        IF    '${item}[3]' != '${EMPTY}'
            SeleniumLibrary.Wait Until Element Is Visible    ${inptPurchaseTarget}
            SeleniumLibrary.Set Focus To Element    ${inptPurchaseTarget}
            Press Keys    ${inptPurchaseTarget}    ${CTRLA}    ${item}[3]
            Sleep    0.5s
            # Clik another element to enable the save button
            Click Element    ${inptAdjustPrice}
        END
        # Change the Price
        IF    '${item}[4]' != '${EMPTY}'
            SeleniumLibrary.Wait Until Element Is Visible    ${inptAdjustPrice}
            SeleniumLibrary.Set Focus To Element    ${inptAdjustPrice}
            Press Keys    ${inptAdjustPrice}    ${CTRLA}    ${item}[4]
            Sleep    0.5s
            # Clik another element to enable the save button
            SeleniumLibrary.Click Element    ${inptPurchaseTarget}
        END
        # Change the Shipment Start
        IF    '${item}[5]' != '${EMPTY}'
            Set new shipping date    start    ${item}[5]
        END
        # Change the Shipment End
        IF    '${item}[6]' != '${EMPTY}'
            Set new shipping date    end    ${item}[6]
        END
        # Check if the ticket should be rejected

        SeleniumLibrary.Element Should Be Enabled    ${btnSave}
        # Click Save button to confirm change
        SeleniumLibrary.Click Element    ${btnSave}
        SeleniumLibrary.Wait Until Element Is Visible    ${txtEditedSuccess}    30s
        SeleniumLibrary.Wait Until Element Is Not Visible    ${txtEditedSuccess}    30s

        # Comment
        SeleniumLibrary.Set Focus To Element    ${inptComment}
        SeleniumLibrary.Input Text    ${inptComment}    Inputted by robot ${username}
        
        # Click ส่งความเห็น
        SeleniumLibrary.Wait Until Element Is Enabled    ${btnSubmit}
        SeleniumLibrary.Set Focus To Element    ${btnSubmit}
        SeleniumLibrary.Press Keys    ${None}    ENTER

        # Click ยืนยัน
        SeleniumLibrary.Wait Until Element Is Visible    ${btnConfirm}
        SeleniumLibrary.Click Element    ${btnConfirm}

        SeleniumLibrary.Wait Until Element Is Not Visible    ${loading}    30s
        SeleniumLibrary.Wait Until Element Is Visible    ${txtCommentSuccess}    30s
        SeleniumLibrary.Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s

        # Wait for reloading page
        SeleniumLibrary.Wait Until Element Is Visible    ${loading}    30s
        SeleniumLibrary.Wait Until Element Is Not Visible    ${loading}    30s
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
    Wait Until Element Is Visible    ${chkAnySupplier1}    30s
    Click Element    ${chkAnySupplier1}
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
    # Add all data set into one matrix
    ${dataMatrix}=    Create List    ${dataApprovalSet1}    ${dataApprovalSet2}    ${dataApprovalSet3}    ${dataApprovalSet4}    ${dataApprovalSet5}
        FOR    ${dataSet}    IN    @{dataMatrix}
            # Log To Console    Data Matrix: ${dataMatrix}
            # Log To Console    Data Set: ${dataSet}
            Log To Console    Current Approver: ${dataSet}[0]
            # Re-login (${dataSet}[0] = approver account, ${dataSet}[1] = password)
            Logout and then login    ${dataSet}[0]   ${dataSet}[1]
            # Approve with expected user, ${dataSet}[0] = approver account
            Run Keyword If    '${RequestType}' == 'Total'   Go to tickets and submit comment - Total    ${env}    ${requestID}    ${dataSet}    ${dataSet}[0]
            # Run Keyword If    '${RequestType}' == 'Any'   Go to tickets and submit comment - Any    ${env}    ${requestID}    ${item}    ${liUsername}[${index}]
            Log To Console    Approved successfully.   
            ${index}=    Evaluate    ${index} + 1
        END
    END

*** Test Cases ***      Request Type        Contract Type          Is Approval
# --------- Use these cases to prepare the test data ---------
Data preparation Flat 1        Total         Flat                  ${False}
Data preparation Basis 1        Total         Basis                  ${False}
Data preparation Flat 2        Total         Flat                  ${TRUE}
Data preparation Basis 2        Total         Basis                  ${TRUE}