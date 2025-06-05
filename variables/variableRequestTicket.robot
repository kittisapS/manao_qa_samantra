*** Variables ***

${btnCreateNewRequest}    xpath: //button[contains(text(),'สร้างคำขอใหม่')]
${h2NewRequestTicket}    xpath: //h2[contains(text(),'สร้างคำขอจัดซื้อ')]
# ----- 1st Criteria -----
${ddlIngredient}    xpath: //label[contains(text(),'วัตถุดิบ')]/following-sibling::ng-select
${ddlContractType}    xpath: //label[contains(text(),'ประเภท')]/following-sibling::ng-select
${ddlDestination}    xpath: //label[contains(text(),'ปลายทาง')]/following-sibling::ng-select
${dateDuedate}    xpath: //label[contains(text(),'วันที่ครบกำหนด')]/following-sibling::app-date-picker//input[@placeholder='วว/ดด/ปป']
${date25}    xpath:  //ngb-datepicker-month//div[text()=' 25 ']
${btnCreateRequest}    xpath: //button[contains(text(),'สร้างรายการ')]

# ----- 2nd Criteria (supplier) -----
${btnAddSupplier}    xpath: //button[text()='เพิ่มรายชื่อคู่ค้า ']
${txtSupplierFlat}    xpath:  //span[contains(text(),'เพิ่มรายการเสนอราคาคู่ค้า')]
${ddlSupplier}    xpath: //label[contains(text(),'ชื่อคู่ค้า')]/following-sibling::ng-select
${li1st}    xpath:    //ng-dropdown-panel//div[1]/span
${inptSpec}    xpath: //input[@id='spec']
${inptQTY}    xpath: //input[@id='quantity']
${ddlDeparture}    xpath: //ng-select[@placeholder='เลือกประเทศต้นทาง']//input
${ddlEndpoint}    xpath: //label[text()='ปลายทาง ']/following-sibling::ng-select[@id='select-destination']
${ddlSeaFrieght}    xpath: //label[contains(text(),'รูปเเบบการจัดส่ง')]/following-sibling::ng-select
${dateShippingStart}    xpath: //app-date-picker[@id='startDate']
${dateShippingEnd}    xpath: //app-date-picker[@placeholder='วันที่สิ้นสุด']
${inptFlat}    xpath: //input[@id='flatUsd']
${inptTrasportFee}    xpath: //input[@id='transportToFactory']
${ddlCalProtein}    xpath: //label[contains(text(),'คำนวณราคาต่อโปรตีน 48% ')]/following-sibling::ng-select
${btnSave}    xpath:  //button[text()=' บันทึก ']

${btnSaveDraft}    xpath: //button[text()=' บันทึกร่าง ']