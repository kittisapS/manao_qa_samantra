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
# assigned list        Username                     Password    Select Supplier    Purchase      Price        Shipment start        Shipment end        isReject          isDataChange
#                                                               (1-4)             (Numeric)     (Numeric)     (Should be 02-30)     (Cannot be 30)      (True/False)      (True/False)
@{dataApprovalSet1}    manaoAutomate_executive01    Qa123456    4                    1000        800.75        ${EMPTY}              ${EMPTY}           ${False}         ${True}
@{dataApprovalSet2}    manaoAutomate_executive02    Qa123456    4                    1000        800.75        ${EMPTY}              ${EMPTY}           ${False}         ${True}
@{dataApprovalSet3}    manaoAutomate_executive03    Qa123456    4                    3000        900.32        ${EMPTY}              ${EMPTY}           ${False}         ${True}
@{dataApprovalSet4}    manaoAutomate_executive04    Qa123456    4                    3000        900.32        ${EMPTY}              ${EMPTY}           ${False}         ${True}
@{dataApprovalSet5}    manaoAutomate_executive05    Qa123456    4                    2000        3813.24        15                25                 ${True}            ${False}
@{dataApprovalSetCEO}  manaoAutomate_ceo            Qa123456    ${EMPTY}            ${EMPTY}     ${EMPTY}     ${EMPTY}      ${EMPTY}               ${False}              ${False}

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
        SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier1}
        # If 1 supplier should not be selected
        IF    '${item}[2]' == '1'  
            # Deselect supplier 4th
            SeleniumLibrary.Set Focus To Element    ${chkSupplier4}
            SeleniumLibrary.Click Element    ${chkSupplier4}
            # Deselect supplier 3rd
            SeleniumLibrary.Set Focus To Element    ${chkSupplier3}
            SeleniumLibrary.Click Element    ${chkSupplier3}
            # Deselect supplier 2nd
            SeleniumLibrary.Set Focus To Element    ${chkSupplier2}
            SeleniumLibrary.Click Element    ${chkSupplier2}
        # If 2 suppliers should not be selected
        ELSE IF    '${item}[2]' == '2'
            # Deselect supplier 4th
            SeleniumLibrary.Set Focus To Element    ${chkSupplier4}
            SeleniumLibrary.Click Element    ${chkSupplier4}
            # Deselect supplier 3rd
            SeleniumLibrary.Set Focus To Element    ${chkSupplier3}
            SeleniumLibrary.Click Element    ${chkSupplier3}
        # If 3 suppliers should not be selected
        ELSE IF    '${item}[2]' == '3'
            # Deselect supplier 4th
            SeleniumLibrary.Set Focus To Element    ${chkSupplier4}
            SeleniumLibrary.Click Element    ${chkSupplier4}
        ELSE
            Log To Console    No changed to suppliers or the value is incorrectly inputted (please input 1-3)
        END
        # Check if an approver is going to change data
        IF        '${item}[8]' == '${True}'
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
                Set new shipping date total    start    ${item}[5]
            END
            # Change the Shipment End
            IF    '${item}[6]' != '${EMPTY}'
                Set new shipping date total    end    ${item}[6]
            END
            SeleniumLibrary.Element Should Be Enabled    ${btnSave}
            # Click Save button to confirm change
            SeleniumLibrary.Click Element    ${btnSave}
            SeleniumLibrary.Wait Until Element Is Visible    ${txtEditedSuccess}    30s
            SeleniumLibrary.Wait Until Element Is Not Visible    ${txtEditedSuccess}    30s
        END
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
    [Arguments]    ${env}    ${requestID}    ${item}    ${username}
    # Go to specified ticket
    Go to Approval on that request ticket    ${env}    ${requestID}
    Wait Until Element Is Visible    ${loading}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    # Check if the ticket should be adjusted or rejected
    IF    '${item}[7]' == '${False}'
        # Check if the suppliers is going to be deselected
        SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier1}
        # If 1 supplier is selected
        IF    '${item}[2]' == '1'  
            # Select 1st checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier1}    30s
            SeleniumLibrary.Click Element    ${chkSupplier1}
        # If 2 suppliers are selected
        ELSE IF    '${item}[2]' == '2'
            # Select 1st checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier1}    30s
            SeleniumLibrary.Click Element    ${chkSupplier1}
            # Select 2nd checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier2}    30s
            SeleniumLibrary.Click Element    ${chkSupplier2}
        # If 3 suppliers are selected
        ELSE IF    '${item}[2]' == '3'
            # Select 1st checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier1}    30s
            SeleniumLibrary.Click Element    ${chkSupplier1}
            # Select 2nd checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier2}    30s
            SeleniumLibrary.Click Element    ${chkSupplier2}
            # Select 3rd checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier3}    30s
            SeleniumLibrary.Click Element    ${chkSupplier3}
        # If 4 suppliers are selected
        ELSE IF    '${item}[2]' == '4'
            # Select 1st checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier1}    30s
            SeleniumLibrary.Click Element    ${chkSupplier1}
            # Select 2nd checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier2}    30s
            SeleniumLibrary.Click Element    ${chkSupplier2}
            # Select 3rd checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier3}    30s
            SeleniumLibrary.Click Element    ${chkSupplier3}
            # Select 4th checkbox
            SeleniumLibrary.Wait Until Element Is Visible    ${chkSupplier4}    30s
            SeleniumLibrary.Click Element    ${chkSupplier4}
        ELSE
            Log To Console    No changed to suppliers or the value is incorrectly inputted (please input 1-4)
        END
        # Check if a user would like to adjust data
        IF    '${item}[8]' == '${True}'
            # Check if the 1st checkbox is checked
            IF    ${item}[2] >= 1 and ${item}[2] > 0
                # Check if the 2nd checkbox is checked
                IF    ${item}[2] >= 2
                    # Check if the 3th checkbox is checked
                    IF    ${item}[2] >= 3
                        # Check if the 4th checkbox is checked
                        IF    ${item}[2] >= 4 
                            # Click ปรับข้อมูล of 4th supplier
                            SeleniumLibrary.Wait Until Element Is Visible    ${btnAdjustDataSupplier4}    30s
                            SeleniumLibrary.Set Focus To Element    ${btnAdjustDataSupplier4}
                            SeleniumLibrary.Click Element    ${btnAdjustDataSupplier4}
                            SeleniumLibrary.Wait Until Element Is Visible    ${txtAnyAdjustPrice}
                            # Check if ปริมาณ should be adjusted
                            IF    '${item}[3]' != '${EMPTY}'
                                # Adjust ปริมาณ
                                SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyPurchase}
                                SeleniumLibrary.Set Focus To Element    ${inptAnyPurchase}
                                SeleniumLibrary.Press Keys    ${inptAnyPurchase}    ${CTRLA}    ${item}[3]
                            END
                            # Check if ราคา should be adjusted
                            IF    '${item}[4]' != '${EMPTY}'
                                # Adjust ปริมาณ
                                SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyNewPriceHigh}
                                SeleniumLibrary.Set Focus To Element    ${inptAnyNewPriceHigh}
                                SeleniumLibrary.Press Keys    ${inptAnyNewPriceHigh}    ${CTRLA}    ${item}[4]
                            END
                            # Check if Shipment start should be adjusted
                            IF    '${item}[5]' != '${EMPTY}'
                                Set new shipping date any    start    ${item}[5]
                            END
                            # Check if Shipment end should be adjusted
                            IF    '${item}[6]' != '${EMPTY}'
                                Set new shipping date any    end    ${item}[6]
                            END
                                        # Comment
                            SeleniumLibrary.Set Focus To Element    ${inptComment}
                            SeleniumLibrary.Input Text    ${inptComment}    Inputted by robot ${username}
                            # Click Save button to confirm change
                            SeleniumLibrary.Element Should Be Enabled    ${btnSave}
                            SeleniumLibrary.Click Element    ${btnSave}
                            SeleniumLibrary.Wait Until Element Is Visible    ${txtCommentSuccess}    30s
                            SeleniumLibrary.Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s
                        END
                        # Click ปรับข้อมูล of 3rd supplier
                        SeleniumLibrary.Wait Until Element Is Visible    ${btnAdjustDataSupplier3}    30s
                        SeleniumLibrary.Set Focus To Element    ${btnAdjustDataSupplier3}
                        SeleniumLibrary.Click Element    ${btnAdjustDataSupplier3}
                        SeleniumLibrary.Wait Until Element Is Visible    ${txtAnyAdjustPrice}
                        # Check if ปริมาณ should be adjusted
                        IF    '${item}[3]' != '${EMPTY}'
                            # Adjust ปริมาณ
                            SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyPurchase}
                            SeleniumLibrary.Set Focus To Element    ${inptAnyPurchase}
                            SeleniumLibrary.Press Keys    ${inptAnyPurchase}    ${CTRLA}    ${item}[3]
                        END
                        # Check if ราคา should be adjusted
                        IF    '${item}[4]' != '${EMPTY}'
                            # Adjust ปริมาณ
                            SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyNewPriceHigh}
                            SeleniumLibrary.Set Focus To Element    ${inptAnyNewPriceHigh}
                            SeleniumLibrary.Press Keys    ${inptAnyNewPriceHigh}    ${CTRLA}    ${item}[4]
                        END
                        # Check if Shipment start should be adjusted
                        IF    '${item}[5]' != '${EMPTY}'
                            Set new shipping date any    start    ${item}[5]
                        END
                        # Check if Shipment end should be adjusted
                        IF    '${item}[6]' != '${EMPTY}'
                            Set new shipping date any    end    ${item}[6]
                        END
                        # Comment
                        SeleniumLibrary.Set Focus To Element    ${inptComment}
                        SeleniumLibrary.Input Text    ${inptComment}    Inputted by robot ${username}
                        # Click Save button to confirm change
                        SeleniumLibrary.Element Should Be Enabled    ${btnSave}
                        SeleniumLibrary.Click Element    ${btnSave}
                        SeleniumLibrary.Wait Until Element Is Visible    ${txtCommentSuccess}    30s
                        SeleniumLibrary.Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s
                    END
                    # Click ปรับข้อมูล of 3rd supplier
                    SeleniumLibrary.Wait Until Element Is Visible    ${btnAdjustDataSupplier2}    30s
                    SeleniumLibrary.Set Focus To Element    ${btnAdjustDataSupplier2}
                    SeleniumLibrary.Click Element    ${btnAdjustDataSupplier2}
                    SeleniumLibrary.Wait Until Element Is Visible    ${txtAnyAdjustPrice}
                    # Check if ปริมาณ should be adjusted
                    IF    '${item}[3]' != '${EMPTY}'
                        # Adjust ปริมาณ
                        SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyPurchase}
                        SeleniumLibrary.Set Focus To Element    ${inptAnyPurchase}
                        SeleniumLibrary.Press Keys    ${inptAnyPurchase}    ${CTRLA}    ${item}[3]
                    END
                    # Check if ราคา should be adjusted
                    IF    '${item}[4]' != '${EMPTY}'
                        # Adjust ปริมาณ
                        SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyNewPriceHigh}
                        SeleniumLibrary.Set Focus To Element    ${inptAnyNewPriceHigh}
                        SeleniumLibrary.Press Keys    ${inptAnyNewPriceHigh}    ${CTRLA}    ${item}[4]
                    END
                    # Check if Shipment start should be adjusted
                    IF    '${item}[5]' != '${EMPTY}'
                        Set new shipping date any    start    ${item}[5]
                    END
                    # Check if Shipment end should be adjusted
                    IF    '${item}[6]' != '${EMPTY}'
                        Set new shipping date any    end    ${item}[6]
                    END
                                # Comment
                    SeleniumLibrary.Set Focus To Element    ${inptComment}
                    SeleniumLibrary.Input Text    ${inptComment}    Inputted by robot ${username}
                    # Click Save button to confirm change
                    SeleniumLibrary.Element Should Be Enabled    ${btnSave}
                    SeleniumLibrary.Click Element    ${btnSave}
                    SeleniumLibrary.Wait Until Element Is Visible    ${txtCommentSuccess}    30s
                    SeleniumLibrary.Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s
                END
                # Click ปรับข้อมูล of 1st supplier
                SeleniumLibrary.Wait Until Element Is Visible    ${btnAdjustDataSupplier1}    30s
                SeleniumLibrary.Set Focus To Element    ${btnAdjustDataSupplier1}
                SeleniumLibrary.Click Element    ${btnAdjustDataSupplier1}
                SeleniumLibrary.Wait Until Element Is Visible    ${txtAnyAdjustPrice}
                # Check if ปริมาณ should be adjusted
                IF    '${item}[3]' != '${EMPTY}'
                    # Adjust ปริมาณ
                    SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyPurchase}
                    SeleniumLibrary.Set Focus To Element    ${inptAnyPurchase}
                    SeleniumLibrary.Press Keys    ${inptAnyPurchase}    ${CTRLA}    ${item}[3]
                END
                # Check if ราคา should be adjusted
                IF    '${item}[4]' != '${EMPTY}'
                    # Adjust ปริมาณ
                    SeleniumLibrary.Wait Until Element Is Visible    ${inptAnyNewPriceHigh}
                    SeleniumLibrary.Set Focus To Element    ${inptAnyNewPriceHigh}
                    SeleniumLibrary.Press Keys    ${inptAnyNewPriceHigh}    ${CTRLA}    ${item}[4]
                END
                # Check if Shipment start should be adjusted
                IF    '${item}[5]' != '${EMPTY}'
                    Set new shipping date any    start    ${item}[5]
                END
                # Check if Shipment end should be adjusted
                IF    '${item}[6]' != '${EMPTY}'
                    Set new shipping date any    end    ${item}[6]
                END
                            # Comment
                SeleniumLibrary.Set Focus To Element    ${inptComment}
                SeleniumLibrary.Input Text    ${inptComment}    Inputted by robot ${username}
                # Click Save button to confirm change
                SeleniumLibrary.Element Should Be Enabled    ${btnSave}
                SeleniumLibrary.Click Element    ${btnSave}
                SeleniumLibrary.Wait Until Element Is Visible    ${txtCommentSuccess}    30s
                SeleniumLibrary.Wait Until Element Is Not Visible    ${txtCommentSuccess}    30s
            END
        END    

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
    ELSE IF    '${item}[7]' == '${True}'
        Reject ticket    ${env}    ${requestID}    ${item}[0]
    END


Create Request Ticket and approve tickets 
    [Arguments]    ${RequestType}    ${ContractType}   ${isApproval}
    # Go to Create request
    Sleep    1s
    Go to Request Ticket menu
    # Create new request ticket and get id
    ${requestID}=     Create new request ticket    ${env}    ${productShortName}    ${RequestType}    ${ContractType}    ${dataDestination}    ${dataOrigin}    ${dataSeaFreight}
    #${requestID}=    Set Variable    4304
    # Assign index for users list
    ${index}=    Set Variable    0
    IF    '${isApproval}' == '${True}'
    # Add all data set into one matrix
    ${dataMatrix}=    Create List    ${dataApprovalSet1}    ${dataApprovalSet2}    ${dataApprovalSet3}    ${dataApprovalSet4}
        FOR    ${dataSet}    IN    @{dataMatrix}
            # Log To Console    Data Matrix: ${dataMatrix}
            # Log To Console    Data Set: ${dataSet}
            Log To Console    Current Approver: ${dataSet}[0]
            # Re-login (${dataSet}[0] = approver account, ${dataSet}[1] = password)
            Logout and then login    ${dataSet}[0]   ${dataSet}[1]
            # Approve with expected user, ${dataSet}[0] = approver account
            Run Keyword If    '${RequestType}' == 'Total'   Go to tickets and submit comment - Total    ${env}    ${requestID}    ${dataSet}    ${dataSet}[0]
            Run Keyword If    '${RequestType}' == 'Any'   Go to tickets and submit comment - Any    ${env}    ${requestID}    ${dataSet}    ${dataSet}[0]
            Log To Console    Approved successfully.   
            ${index}=    Evaluate    ${index} + 1
        END
    END

*** Test Cases ***      Request Type        Contract Type          Is Approval
# --------- Use these cases to prepare the test data ---------
Data preparation Flat 1        Any         Flat                  ${True}
Data preparation Basis 1        Any         Basis                  ${False}
Data preparation Flat 2        Total         Flat                  ${TRUE}
Data preparation Basis 2        Total         Basis                  ${TRUE}