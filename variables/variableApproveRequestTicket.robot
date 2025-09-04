*** Variables ***
${urlApproveDev}    https://samantra-dev.fitcp.com/globaltrade/details-ticket/
${urlApproveSTG}    https://samantra-staging.fitcp.com/globaltrade/details-ticket/
${h2TicketApproval}    xpath: //h2[contains(text(),'รายละเอียดขออนุมัติจัดซื้อ')]

# ----- Universal -----
${chkSupplier1}    xpath: //supplier-list/div/div[1]//mat-checkbox
${chkSupplier2}    xpath: //supplier-list/div/div[2]//mat-checkbox
${chkSupplier3}    xpath: //supplier-list/div/div[3]//mat-checkbox
${chkSupplier4}    xpath: //supplier-list/div/div[4]//mat-checkbox

# ----- Total -----
${btnAdjustData}    xpath: //button[contains(text(),'ปรับข้อมูล')]


# ----- Any -----
${btnAdjustDataSupplier1}    xpath: //supplier-list//div[@class='comp-item-container supplier-item boder-bottom-none recommended'][1]//button[contains(text(),'ปรับข้อมูล')]
${btnAdjustDataSupplier2}    xpath: //supplier-list//div[@class='comp-item-container supplier-item boder-bottom-none recommended'][2]//button[contains(text(),'ปรับข้อมูล')]
${btnAdjustDataSupplier3}    xpath: //supplier-list//div[@class='comp-item-container supplier-item boder-bottom-none recommended'][3]//button[contains(text(),'ปรับข้อมูล')]
${btnAdjustDataSupplier4}    xpath: //supplier-list//div[@class='comp-item-container supplier-item boder-bottom-none recommended'][4]//button[contains(text(),'ปรับข้อมูล')]
${txtAnyAdjustPrice}    xpath: //label[contains(text(),'แก้ไขรายการเสนอราคา')]
${inptAnyPurchase}    xpath: //input[@formcontrolname='quantityNew']
${inptAnyNewPriceHigh}    xpath: //input[@formcontrolname='priceHighNew']
${dpkAnyShipmentStart}    xpath: //app-date-picker[@id='shipmentStartDateNew']
${dpkAnyShipmentEnd}    xpath: //app-date-picker[@id='shipmentEndDateNew']
${btnAnySubmit}    xpath: //div[@class='form-actions']/div[1]//button[contains(text(),'ส่งความคิดเห็น')]

# Modal Adjust data
${h4AdjustData}    xpath: //h4[contains(text(),'แก้ไขรายการเสนอแบบรวมปริมาณ')]
${inptPurchaseTarget}    xpath: //input[@formcontrolname='targetQuantity']
${inptAdjustPrice}    xpath: //input[@title='Number Input']
${shipmentStart1}    xpath: //div[1]/div/div[1]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentEnd1}    xpath: //div[1]/div/div[2]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentStart2}    xpath: //div[2]/div/div[1]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentEnd2}    xpath: //div[2]/div/div[2]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentStart3}    xpath: //div[3]/div/div[1]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentEnd3}    xpath: //div[3]/div/div[2]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentStart4}    xpath: //div[4]/div/div[1]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${shipmentEnd4}    xpath: //div[4]/div/div[2]/app-date-picker//input[@placeholder='DD/MM/YYYY']
${btnSave}    xpath: //button[contains(text(),'บันทึก')]

${inptComment}    xpath: //textarea[@id='price-additional-info']
${btnSubmit}    xpath: //div[@class='form-actions']/div[1]//button[contains(text(),'ส่งความคิดเห็น')]

# Reject ticket
${btnRejectTicket}    xpath: //button[contains(text(),'ปฏิเสธคำขอจัดซื้อ')]
${btnConfirm}    xpath: //button[text()='ยืนยัน']
${inptRejectComment}    xpath: //div[@class='modal-content']//textarea[@id='price-additional-info']
${btnConfirmReject}    xpath: //div[@class='modal-content']//button[contains(text(),'ปฏิเสธคำขอจัดซื้อ')]