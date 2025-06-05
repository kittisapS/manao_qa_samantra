*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/globalVariable.robot

*** Keywords ***

Open Samantra and login
    [Arguments]    ${url}    ${browser}
    SeleniumLibrary.Open Browser    ${url}   ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element Is Visible    ${h1Login}
    SeleniumLibrary.Input Text    ${inptUsername}    ${txtUsername}
    SeleniumLibrary.Input Text    ${inptPassword}    ${txtPassword}
    SeleniumLibrary.Click Element    ${btnLogin}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2Welcome}
 
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

Select value from
    [Arguments]    ${element}    ${list}
    SeleniumLibrary.Wait Until Element Is Visible    ${element}    10s
    SeleniumLibrary.Click Element    ${element}
    SeleniumLibrary.Wait Until Element Is Visible    ${list}    10s
    SeleniumLibrary.Set Focus To Element    ${list}
    SeleniumLibrary.Click Element    ${list}