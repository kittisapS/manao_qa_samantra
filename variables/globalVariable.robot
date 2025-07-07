*** Variables ***

## ----- Login -----
${urlDev}    https://samantra-dev.fitcp.com/
${urlSTG}    https://samantra-staging.fitcp.com/starter
${chrome}    chrome
${h1Login}    xpath: //h1[contains(text(),'Log In')]
${inptUsername}    xpath: //input[@id='username']
${inptPassword}    xpath: //input[@id='password']
${btnLogin}    xpath: //input[@id='kc-login']
${h2Welcome}    xpath: //h2[contains(text(),'Welcome to FIT Samantra.')]
${loading}    xpath:  //div[@class='cdk-overlay-container']
## Parameters
${txtUsername}    manao_trader
${txtPassword}    123456
## ----- End Login -----

## ----- Main Menu -----
${menuInterTrade}    xpath: //div/a[contains(text(),'Inter Trade')]
## ----- Menu Request Ticket -----
${subMenuRequestTicket}    xpath: //li/a[contains(text(),'Request Ticket')]
${h2RequestTicket}    xpath: //h2[contains(text(),'รายการคำขอจัดซื้อขออนุมัติ')]

## ----- Menu Business Conclude -----
${subMenuBusinessConclude}    xpath: //li/a[contains(text(),'Business Conclude')]
${h4BusinessConclude}    xpath: //h4[contains(text(),'Business Conclude Page')]

## ----- Toast message -----
${txtSuccess}    xpath: //h4[text()='บันทึกเรียบร้อย']  