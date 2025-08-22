*** Variables ***
# Username list
# Set 1
@{usernameSet1}    manaoAutomate_executive01	  manaoAutomate_executive02   manaoAutomate_executive03   manaoAutomate_executive04   manaoAutomate_executive05    manaoAutomate_ceo
${passwordApproverSet1}    Qa123456
# Set 2
@{usernameSet2}    manao_executive01	  manao_executive02   manao_executive03   manao_executive04   manao_executive05    manao_ceo02
${passwordApproverSet2}    123456
# Set 3
@{usernameSet3}    executive-01	  executive-02   executive-03   executive-04   executive-05    ceo-01
${passwordApproverSet3}    123456

# Key
${CTRLA}    CTRL+A

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
${btnMenu}    xpath: //img[@id='nav-user']
${btnLogout}    xpath: //a[text()='Logout ']
${btnOK}    xpath: //button[text()='OK']
${toastLoginSuccess}    xpath: //div[@role='alertdialog' and @aria-label='Login successfully.']
## Parameters
${txtUsername}    manao_trader
${txtPassword}    123456
## ----- End Login -----

## ----- Main Menu -----
${menuInterTrade}    xpath: //div/a[contains(text(),'Inter Trade')]
${menuApproval}    xpath: //div/a[contains(text(),'Approval')]

## ----- Menu Request Ticket -----
${subMenuRequestTicket}    xpath: //li/a[contains(text(),'Request Ticket')]
${h2RequestTicket}    xpath: //h2[contains(text(),'รายการคำขอจัดซื้อขออนุมัติ')]
${h2RequestTicketDetail}    xpath: //h2[contains(text(),'รายละเอียดคำขอจัดซื้อ')]

## ----- Menu Business Conclude -----
${subMenuBusinessConclude}    xpath: //li/a[contains(text(),'Business Conclude')]
${h4BusinessConclude}    xpath: //h4[contains(text(),'Business Conclude Page')]

## ----- Menu Approval -----
${subMenuApproveRequestTicket}    xpath: //li/a[contains(text(),'Ticket Global Trade')]
${h2ApproveRequestTicket}    xpath: //h2[contains(text(),'รายการขออนุมัติจัดซื้อ')]
${Reject}    Reject

## ----- Toast message -----
${txtSuccess}    xpath: //h4[text()='บันทึกเรียบร้อย']
${txtEditedSuccess}    xpath: //h4[text()='บันทึกสำเร็จ']
${txtRequestSuccess}    xpath: //h4[text()='ส่งคำขออนุมัติสำเร็จ']
${txtCommentSuccess}    xpath: //h4[text()='ส่งความคิดเห็นสำเร็จ']  