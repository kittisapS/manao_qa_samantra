*** Settings ***
Library    String
Resource    ../keyword/globalKeyword.robot
Suite Setup    Open Samantra and login    ${urlSTG}    ${chrome}
Suite Teardown    Close All Browsers

*** Variables ***
${hRequestNo}    xpath: //h4[contains(text(),'เลขที่คำขอจัดซื้อ')]
${btnMenu}    xpath: //div[@class='user-info d-lg-flex flex-column d-md-none d-sm-none d-none']
${btnLogout}    xpath: //a[text()='Logout ']


*** Keywords ***

*** Test Cases ***
Get request no
    Go To    https://samantra-staging.fitcp.com/globaltrade/request-ticket/proposaledit/136
    Wait Until Element Is Not Visible    ${loading}
    Wait Until Element Is Visible    ${hRequestNo}
    ${rawText}=    Get Text    ${hRequestNo}
    Log To Console    Raw text: ${rawText}
    ${trimmedText}=    Strip String    ${rawText}
    Log To Console    Trimmed text: ${trimmedText}
    ${orderNo}=    Replace String    ${trimmedText}    เลขที่คำขอจัดซื้อ :    ${EMPTY}
    Log To Console    OrderNo: ${orderNo}

