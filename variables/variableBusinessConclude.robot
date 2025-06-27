*** Variables ***

# ----- Business Conclude List page -----
${btnAddNew}    xpath: //button[contains(text(),'Add New')]
${modalContractType}    xpath: //h4[contains(text(),' Please Select Contract Type ')]/ancestor::div/div[@class='modal-content']
${radioBasis}    xpath: //label[contains(text(),' Basis ')]
${radioFlat}    xpath: //label[contains(text(),' Flat ')]
${btnConfirm}    xpath: //button[contains(text(),'Confirm')]
${btnCancel}    xpath: //button[contains(text(),'cancel')]

## ------ Add New Business Conclude -----
${h4AddBusinessConclude}    xpath: //h4[contains(text(),'Add Business Conclude Page')]
${ddlProduct}    xpath: //label[contains(text(),'Product')]//ng-select
${liProduct}    xpath: //span[text()='SOYBEAN MEAL   - USA']/parent::div
${btnYes}    xpath: //button[text()='Yes']
${radioPlantType}    xpath: //label[text()='AGRO']
${dateConclude}    xpath: //app-date-picker[@id='concludeDate']
${inptPrice}    xpath: //input[@name='price']
${inptBasis}    xpath: //label[text()='Basis (USD/ShortTon) ']//input
${inptCBOT}    xpath: //label[text()='Average CBOT (USD/ShortTon) ']//input
${inptCNF}    xpath: //input[@id='cnfBase']
${inptCNFPrice}    xpath: //input[@id='cnfPrice']
${inptQTY}    xpath: //input[@name='quantity']
${inptTorelance}    xpath: //input[@id='tolerance']
${radioSeaFreight}    xpath: //label[text()='Conventional Vessel']
${chkPackage}    xpath: //label[text()='Bulk']/preceding-sibling::input
${ddlPayment}    xpath: //ng-select[@name='payment']
${liPayment}    xpath: //span[text()='T/T']/parent::div
${radioPaymentType}    xpath: //label[text()='Sight']/parent::div
${dateShippingStart}    xpath: //app-date-picker[@id='shipmentStartDate']
${dateShippingEnd}    xpath: //app-date-picker[@id='shipmentEndDate']
${ddlTermOfDelivery}    xpath: //ng-select[@name='termOfDelivery']
${liTermOfDelivery}    xpath: //span[text()='FOB']/parent::div
${ddlCustomer}    xpath: //ng-select[@placeholder='Input Buyer Name']
${ddlCustomerAddress}    xpath: //ng-select[@placeholder='Input Buyer Address']
${ddlSupplier}    xpath: //ng-select[@placeholder='Input Seller Name']
${ddlSupplierAddress}    xpath: //ng-select[@placeholder='Input Seller Address']
${ddlOriginCountry}    xpath: //label[text()='Origin Country ']/ng-select[@placeholder='Input Country Name']
${ddlOriginPort}    xpath: //label[text()='Origin Port ']//div[@role='combobox']
${ddlDestinationCountry}    xpath: //label[text()='Destination Country ']/ng-select[@placeholder='Input Country Name']
${ddlDestinationPort}    xpath: //label[text()='Destination Port ']//div[@role='combobox']
${divFooter}    xpath: //div[@class='new-footer']
${btnSubmitBC}    xpath: //button[text()=' Submit ']
${modalConfirmTransaction}    xpath: //div//h2[text()='Do you confirm This Transaction']
${modalSuccess}    xpath: //div//div[text()='New transaction has been added.']
${btnOK}    xpath: //button[text()='OK']
## ------ End Add New Business Conclude -----