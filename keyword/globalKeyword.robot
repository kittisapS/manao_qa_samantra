*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/globalVariable.robot

*** Keywords ***
Open Samantra and login
    [Arguments]    ${env}    ${browser}    ${username}    ${password}
    IF    '${env}' == 'DEV'    
        SeleniumLibrary.Open Browser    ${urlDev}   ${browser}
    ELSE IF    '${env}' == 'STG'    
        SeleniumLibrary.Open Browser    ${urlSTG}   ${browser}
    ELSE
        Log To Console    Please specify correct environment (DEV or STG).
        Close All Browsers
    END

    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element Is Visible    ${h1Login}
    Run Keyword If    '${username}' == '${EMPTY}'      SeleniumLibrary.Input Text    ${inptUsername}    ${txtUsername}
    Run Keyword If    '${password}' == '${EMPTY}'    SeleniumLibrary.Input Text    ${inptPassword}    ${txtPassword}
    Run Keyword If    '${username}' != '${EMPTY}'      SeleniumLibrary.Input Text    ${inptUsername}    ${username}
    Run Keyword If    '${password}' != '${EMPTY}'    SeleniumLibrary.Input Text    ${inptPassword}    ${password}
    SeleniumLibrary.Click Element    ${btnLogin}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2Welcome}
    Wait Until Element Is Visible    ${toastLoginSuccess}    10s
    Click Element    ${toastLoginSuccess}
    Wait Until Element Is Not Visible    ${toastLoginSuccess}    10s

Logout and then login
    [Arguments]    ${newUsername}    ${newPassword}
    SeleniumLibrary.Wait Until Element Is Visible    ${btnMenu}    30s
    Set Focus To Element    ${btnMenu}
    Press Keys    ${btnMenu}    ENTER
    #SeleniumLibrary.Click Element    ${btnMenu}
    SeleniumLibrary.Wait Until Element Is Visible    ${btnLogout}    30s
    SeleniumLibrary.Click Element    ${btnLogout}
    # Check error credential error modal
    ${stateErrorModal}=    Run Keyword And Return Status    SeleniumLibrary.Wait Until Element Is Visible    ${btnOK}    10s
    Run Keyword If    '${stateErrorModal}' == 'True'   SeleniumLibrary.Click Element    ${btnOK}
    SeleniumLibrary.Wait Until Element Is Visible    ${inptUsername}    30s
    SeleniumLibrary.Input Text    ${inptUsername}    ${newUsername}
    SeleniumLibrary.Input Text    ${inptPassword}    ${newPassword}
    SeleniumLibrary.Click Element    ${btnLogin}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2Welcome}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
    Wait Until Element Is Visible    ${toastLoginSuccess}    10s
    Click Element    ${toastLoginSuccess}
    Wait Until Element Is Not Visible    ${toastLoginSuccess}    10s
 
Go to Request Ticket menu
    SeleniumLibrary.Click Element    ${menuInterTrade}
    SeleniumLibrary.Wait Until Element Is Visible    ${subMenuRequestTicket}    30s
    SeleniumLibrary.Click Element    ${subMenuRequestTicket}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2RequestTicket}    30s

Go to Business Conclude menu
    SeleniumLibrary.Click Element    ${menuInterTrade}
    SeleniumLibrary.Wait Until Element Is Visible    ${subMenuBusinessConclude}    30s
    SeleniumLibrary.Click Element    ${subMenuBusinessConclude}
    SeleniumLibrary.Wait Until Element Is Visible    ${h4BusinessConclude}    30s

Go to Approval Global Ticket menu
    SeleniumLibrary.Click Element    ${menuApproval}
    SeleniumLibrary.Wait Until Element Is Visible    ${subMenuApproveRequestTicket}    30s
    SeleniumLibrary.Click Element    ${subMenuApproveRequestTicket}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2ApproveRequestTicket}    30s
    Wait Until Element Is Not Visible    ${loading}    30s

Select value from
    [Arguments]    ${element}    ${list}
    SeleniumLibrary.Wait Until Element Is Visible    ${element}    10s
    SeleniumLibrary.Click Element    ${element}
    SeleniumLibrary.Wait Until Element Is Visible    ${list}    10s
    SeleniumLibrary.Set Focus To Element    ${list}
    SeleniumLibrary.Click Element    ${list}