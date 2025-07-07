*** Variables ***

${btnCreateNewRequest}    xpath: //button[contains(text(),'สร้างคำขอใหม่')]
${h2NewRequestTicket}    xpath: //h2[contains(text(),'สร้างคำขอจัดซื้อ')]
# ----- 1st Criteria -----
${ddlRequestType}    xpath: //ng-select[@id='select-request-type']
${liTotal}    xpath: //div/span[text()='รวมปริมาณ']
${ddlContractType}    xpath: //label[contains(text(),'ประเภทการซื้อ')]/following-sibling::ng-select
${ddlIngredient}    xpath: //label[contains(text(),'วัตถุดิบ')]/following-sibling::ng-select
${ddlDestination}    xpath: //label[contains(text(),'ปลายทาง')]/following-sibling::ng-select
${dateDuedate}    xpath: //label[contains(text(),'วันที่ครบกำหนด')]/following-sibling::app-date-picker//input[@placeholder='วว/ดด/ปป']
${date25}    xpath:  //ngb-datepicker-month//div[text()=' 25 ']
${btnCreateRequest}    xpath: //button[contains(text(),'สร้างรายการ')]

# ----- 2nd Criteria (supplier) -----
${btnAddSupplier}    xpath: //button[text()='เพิ่มรายชื่อคู่ค้า ']
${txtSupplierFlat}    xpath: //span[contains(text(),'เพิ่มรายการเสนอราคาคู่ค้า')]
${ddlSupplier}    xpath: //label[contains(text(),'ชื่อคู่ค้า')]/following-sibling::ng-select
${li1st}    xpath: //ng-dropdown-panel//div[1]/span
${inptSpec}    xpath: //input[@id='spec']
${inptMaxCapacity}    xpath: //label[text()='Max Capacity ']//following-sibling::app-unit-input//input
${ddlOrigin}    xpath: //ng-select[@placeholder='เลือกประเทศต้นทาง']//input
${ddlProductOrigin}    xpath: //ng-select[@id='select-product-origin']
${ddlEndpoint}    xpath: //label[text()='ปลายทาง ']/following-sibling::ng-select[@id='select-destination']
${ddlSeaFrieght}    xpath: //label[contains(text(),'รูปเเบบการจัดส่ง')]/following-sibling::ng-select
${ddlPackage}    xpath: //ng-select[@id='select-master-package']
${dateShippingStart}    xpath: //app-date-picker[@id='startDate']
${dateShippingEnd}    xpath: //app-date-picker[@placeholder='วันที่สิ้นสุด']
${ddlContract}    xpath: //ng-select[@id='select-cbot-contract']
${inptFlat}    xpath: //input[@id='flatUsd']
${inptTrasportFee}    xpath: //input[@id='transportToFactory']
${inptBasis}    xpath: //input[@id='basic']
${inptCBOT}    xpath: //input[@id='cbot']
${ddlCalProtein}    xpath: //label[contains(text(),'คำนวณราคาต่อโปรตีน 48% ')]/following-sibling::ng-select
${btnSave}    xpath: //button[text()=' บันทึก ']

${dataShippingStart}     xpath: //ngb-datepicker-month//div[@aria-label='Tuesday, July 1, 2025']/div[text()=' 1 ']
${dataShippingEnd}       xpath: //ngb-datepicker-month//div[@aria-label='Thursday, July 31, 2025']/div[text()=' 31 ']
${inptTopic}    xpath: //input[@name='topic']
${inptAdditionalDetail}    xpath: //h4[contains(text(),'เสนอ')]//ancestor::div/form//textarea[@id='additionalInfo']
${btnConfirm}    xpath: //button[text()='ยืนยัน']

${btnSaveDraft}    xpath: //button[text()=' บันทึกร่าง ']
${btnSubmitRequest}    xpath: //button[text()=' ส่งคำขออนุมัติ ']

# ----- After saving -----
${hRequestNo}    xpath: //h4[contains(text(),'เลขที่คำขอจัดซื้อ')]