*** Variables ***
${urlApproveDev}    https://samantra-dev.fitcp.com/globaltrade/details-ticket/
${urlApproveSTG}    https://samantra-staging.fitcp.com/globaltrade/details-ticket/
${h2TicketApproval}    xpath: //h2[contains(text(),'รายละเอียดขออนุมัติจัดซื้อ')]

${btnAdjustData}    xpath: //button[contains(text(),'ปรับข้อมูล')]

# Modal Adjust data
${h4AdjustData}    xpath: //h4[contains(text(),'แก้ไขรายการเสนอแบบรวมปริมาณ')]
${inptAdjustPrice}    xpath: //input[@title='Number Input']
${btnSave}    xpath: //button[contains(text(),'บันทึก')]

${inptComment}    xpath: //textarea[@id='price-additional-info']
${btnSubmit}    xpath: //div[@class='form-actions']/div[1]//button[contains(text(),'ส่งความคิดเห็น')]