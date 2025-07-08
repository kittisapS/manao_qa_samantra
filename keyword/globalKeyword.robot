*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/globalVariable.robot

*** Keywords ***
Open Samantra and login
    [Arguments]    ${url}    ${browser}    ${username}    ${password}
    SeleniumLibrary.Open Browser    ${url}   ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element Is Visible    ${h1Login}
    Run Keyword If    '${username}' == '${EMPTY}'      SeleniumLibrary.Input Text    ${inptUsername}    ${txtUsername}
    Run Keyword If    '${password}' == '${EMPTY}'    SeleniumLibrary.Input Text    ${inptPassword}    ${txtPassword}
    Run Keyword If    '${username}' != '${EMPTY}'      SeleniumLibrary.Input Text    ${inptUsername}    ${username}
    Run Keyword If    '${password}' != '${EMPTY}'    SeleniumLibrary.Input Text    ${inptPassword}    ${password}
    SeleniumLibrary.Click Element    ${btnLogin}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2Welcome}

Logout and then login
    [Arguments]    ${newUsername}    ${newPassword}
    SeleniumLibrary.Wait Until Element Is Visible    ${btnMenu}    30s
    SeleniumLibrary.Click Element    ${btnMenu}
    SeleniumLibrary.Wait Until Element Is Visible    ${btnLogout}    30s
    SeleniumLibrary.Click Element    ${btnLogout}
    SeleniumLibrary.Wait Until Element Is Visible    ${btnOK}    30s
    SeleniumLibrary.Click Element    ${btnOK}
    SeleniumLibrary.Wait Until Element Is Visible    ${inptUsername}    30s
    SeleniumLibrary.Input Text    ${inptUsername}    ${newUsername}
    SeleniumLibrary.Input Text    ${inptPassword}    ${newPassword}
    SeleniumLibrary.Click Element    ${btnLogin}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2Welcome}    30s
    Wait Until Element Is Not Visible    ${loading}    30s
 
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