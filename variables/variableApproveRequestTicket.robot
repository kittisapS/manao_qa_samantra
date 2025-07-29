*** Variables ***
${urlApproveDev}    https://samantra-dev.fitcp.com/globaltrade/details-ticket/
${urlApproveSTG}    https://samantra-staging.fitcp.com/globaltrade/details-ticket/
${h2TicketApproval}    xpath: //h2[contains(text(),'รายละเอียดขออนุมัติจัดซื้อ')]

# ----- Total -----
${btnAdjustData}    xpath: //button[contains(text(),'ปรับข้อมูล')]

# ----- Any -----
# Supplier table
${chkSupplier1}    xpath: //supplier-list//div[@class='comp-item-container supplier-item boder-bottom-none'][1]//mat-checkbox
${btnAdjustDataSupplier1}    xpath: //supplier-list//div[@class='comp-item-container supplier-item boder-bottom-none recommended'][1]//button[contains(text(),'ปรับข้อมูล')]
${txtAnyAdjustPrice}    xpath: //label[contains(text(),'แก้ไขรายการเสนอราคา')]
${inptAnyNewPriceHigh}    xpath: //input[@formcontrolname='priceHighNew']
${btnAnySubmit}    xpath: //div[@class='form-actions']/div[1]//button[contains(text(),'ส่งความคิดเห็น')]

# Modal Adjust data
${h4AdjustData}    xpath: //h4[contains(text(),'แก้ไขรายการเสนอแบบรวมปริมาณ')]
${inptPurchaseTarget}    xpath: //input[@formcontrolname='targetQuantity']
${inptAdjustPrice}    xpath: //input[@title='Number Input']
${btnSave}    xpath: //button[contains(text(),'บันทึก')]

${inptComment}    xpath: //textarea[@id='price-additional-info']
${btnSubmit}    xpath: //div[@class='form-actions']/div[1]//button[contains(text(),'ส่งความคิดเห็น')]