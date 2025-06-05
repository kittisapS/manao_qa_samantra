*** Settings ***
Library    SeleniumLibrary
Suite Setup    Samantra setup    ${urlDev}    ${chrome}
Test Template    Create new request ticket

*** Variables ***

## ----- Login -----
${urlDev}    https://samantra-dev.fitcp.com/
${urlSTG}    https://samantra-dev.fitcp.com/
${chrome}    chrome
${h1Login}    xpath: //h1[contains(text(),'Log In')]
${inptUsername}    xpath: //input[@id='username']
${inptPassword}    xpath: //input[@id='password']
${btnLogin}    xpath: //input[@id='kc-login']
${h2Welcome}    xpath: //h2[contains(text(),'Welcome to FIT Samantra.')]
## Parameters
${txtUsername}    Manao_Peepo
${txtPassword}    Manao100%
## ----- End Login -----

${loading}    xpath:  //div[@class='cdk-overlay-container']
${menuInterTrade}    xpath: //div/a[contains(text(),'Inter Trade')]
${subMenuRequestTicket}    xpath: //li/a[contains(text(),'Request Ticket')]
${h2RequestTicket}    xpath: //h2[contains(text(),'รายการคำขอจัดซื้อขออนุมัติ')]
${btnCreateNewRequest}    xpath: //button[contains(text(),'สร้างคำขอใหม่')]
${h2NewRequestTicket}    xpath: //h2[contains(text(),'สร้างคำขอจัดซื้อ')]
${ddlIngredient}    xpath: //label[contains(text(),'วัตถุดิบ')]/following-sibling::ng-select
${ddlContractType}    xpath: //label[contains(text(),'ประเภท')]/following-sibling::ng-select
${ddlDestination}    xpath: //label[contains(text(),'ปลายทาง')]/following-sibling::ng-select
${dateDuedate}    xpath: //label[contains(text(),'วันที่ครบกำหนด')]/following-sibling::app-date-picker//input[@placeholder='วว/ดด/ปป']
${date25}    xpath:  //ngb-datepicker-month//div[text()=' 25 ']
${btnCreateRequest}    xpath: //button[contains(text(),'สร้างรายการ')]
# Add new supplier
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
${txtSuccess}    xpath: //h4[text()='บันทึกเรียบร้อย'] 

*** Test Cases ***        Ingrediant        Contract Type       Destination        Origin         SeaFreight
Case_Flat_1               SBM               Flat                Thailand        BRA               Conventional Vessel
# Case_Flat_2               SBM               Flat                Thailand        IND               Container
# Case_Flat_3               SBM               Flat                Cambodia        IND               Container
# Case_Flat_4               SBM               Flat                Philippines        IND               Container
# Case_Flat_5               SBM               Flat                Malaysia        IND               Container
# Case_Flat_6               SBM               Flat                Lao People Democratic Republic        IND               Container
# Case_Flat_7               SB                Flat                Thailand        USA               Container
# Case_Flat_8               SB                Flat                Viet Nam       USA               Container
# Case_Flat_9               SB                Flat                Cambodia       USA               Container
# Case_Flat_10              SB                Flat                Malaysia        USA               Container
# Case_Flat_11              SB                Flat                Lao People Democratic Republic       USA               Container
# Case_Flat_12              SB                Flat                Philippines       USA               Container
# Case_Flat_13              PORKMEAL          Flat                Thailand       FRA               Container
# Case_Flat_14              PORKMEAL          Flat                Thailand       DEU               Container
# Case_Flat_15              PORKMEAL          Flat                Thailand       ESP               Container
# Case_Flat_16              PM                Flat                Thailand       GBR               Container
# Case_Flat_17              PM                Flat                Thailand       DEU               Container
# Case_Flat_18              PM                Flat                Thailand       POL               Container
# Case_Flat_19              PM                Flat                Thailand       ESP               Container
# Case_Flat_20              PORKMEAL          Flat                Lao People Democratic Republic       DEU               Container
# Case_Flat_21              DDGS              Flat                Thailand        USA             Container
# Case_Flat_23              CGM               Flat                MALAYSIA        USA			    Container
# Case_Flat_24              SBM	            Flat            	Viet Nam	    BRA            	Conventional Vessel
# Case_Flat_25              SBM               Flat             	Viet Nam        ARG             Conventional Vessel
# Case_Flat_26              SBM               Flat                Viet Nam        USA             Conventional Vessel
# Case_Flat_27              SBM               Flat                Viet Nam        USA             Container
# Case_Flat_28              SBM               Flat                Cambodia        USA             Container
# Case_Flat_29              DDGS              Flat                Cambodia	    ANZ             Container
# Case_Flat_30              DDGS              Flat                Viet Nam	    USA             Container
# Case_Flat_31              DDGS              Flat                Lao People Democratic Republic	    USA        Container
# Case_Flat_32              DDGS              Flat                Philippines	    USA             Container
# Case_Flat_33              DDGS              Flat                Malaysia	    USA             Container
# Case_Flat_34              MBM               Flat                Malaysia	    AUS             Container
# Case_Flat_35              MBM               Flat                Myanmar        ITA             Container
# Case_Flat_36              MBM               Flat                Myanmar        DEU             Container
# Case_Flat_37              MBM               Flat                Myanmar        FRA             Container
# Case_Flat_38              MBM               Flat                Myanmar        GBR             Container
# Case_Flat_39              SBM               Flat                Thailand       GBR             Conventional Vessel
# Case_Flat_40              SBM               Flat                Thailand       GBR             Container
# Case_Flat_41              FW                Flat                Thailand       AUS             Conventional Vessel
# Case_Flat_42              SFM               Flat                Thailand       UKR             Container
# Case_Flat_43              SFM               Flat                Malaysia       UKR             Container
# Case_Flat_44              SFM               Flat                Lao People Democratic Republic       UKR             Container
# Case_Flat_45              SFM               Flat                Philippines       UKR             Container
# Case_Flat_46              SFM               Flat                Viet Nam       UKR             Container
# Case_Flat_47              SFM               Flat                Myanmar       UKR             Container
# Case_Flat_48              SFM               Flat                Bangladesh       UKR             Container
# Case_Flat_49              SFM               Flat                Thailand       ARG             Container
# Case_Flat_50              SFM               Flat                Malaysia       ARG             Container
# Case_Flat_51              SFM               Flat                Lao People Democratic Republic       ARG             Container
# Case_Flat_52              SFM               Flat                Philippines       ARG             Container
# Case_Flat_53              SFM               Flat                Viet Nam       ARG             Container
# Case_Flat_54              SFM               Flat                Myanmar       ARG             Container
# Case_Flat_55              SFM               Flat                Bangladesh       ARG             Container
# Case_Flat_56              SFMP              Flat                Thailand       ARG             Container
# Case_Flat_57              SFMP              Flat                Malaysia       ARG             Container
# Case_Flat_58              SFMP              Flat                Thailand       UKR             Container
# Case_Flat_59              SFMP              Flat                Malaysia       UKR             Container
# Case_Basis_1              SBM               Basis               Thailand        BRA            Conventional Vessel
# Case_Basis_2              SBM               Basis               Thailand        IND            Container
# Case_Basis_3              SBM               Basis               Cambodia        IND            Container
# Case_Basis_4              SB                Basis               Viet Nam        USA               Container
# Case_Basis_5              SB                Basis               Thailand        USA               Container
# Case_Basis_6              PORKMEAL          Basis               Thailand       DEU               Container
# Case_Basis_7              PM                Basis               Thailand        POL             Container
# Case_Basis_8              CGM               Basis               Malaysia        USA             Container
# Case_Basis_9              DDGS              Basis               Lao People Democratic Republic	USA	        Container
# Case_Basis_10             MBM               Basis               Myanmar         ITA             Container
# Case_Basis_11             FW	            Basis                Thailand           AUS	            Conventional Vessel
# Case_Basis_12             SFM	            Basis                Lao People Democratic Republic        UKR         Container
# Case_Basis_13             SFMP              Basis               Thailand        UKR             Container
# Case_Basis_14             SFMP              Basis               Malaysia        UKR             Container

*** Keywords ***
Samantra setup
    [Arguments]    ${url}    ${browser}
    SeleniumLibrary.Open Browser    ${url}   ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element Is Visible    ${h1Login}
    SeleniumLibrary.Input Text    ${inptUsername}    ${txtUsername}
    SeleniumLibrary.Input Text    ${inptPassword}    ${txtPassword}
    SeleniumLibrary.Click Element    ${btnLogin}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2Welcome}
    Go to Request Ticket menu

Go to Request Ticket menu
    SeleniumLibrary.Click Element    ${menuInterTrade}
    SeleniumLibrary.Wait Until Element Is Visible    ${subMenuRequestTicket}    30s
    SeleniumLibrary.Click Element    ${subMenuRequestTicket}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2RequestTicket}    30s

Select value from
    [Arguments]    ${element}    ${list}
    SeleniumLibrary.Wait Until Element Is Visible    ${element}    10s
    SeleniumLibrary.Click Element    ${element}
    SeleniumLibrary.Wait Until Element Is Visible    ${list}    10s
    SeleniumLibrary.Set Focus To Element    ${list}
    SeleniumLibrary.Click Element    ${list}

Create new request ticket
    [Arguments]    ${ingredient}    ${contractType}    ${destination}    ${origin}    ${seaFreight}
    # Create new request
    SeleniumLibrary.Wait Until Element Is Visible    ${btnCreateNewRequest}
    Wait Until Element Is Not Visible   ${loading}
    Wait Until Element Is Not Visible    ${txtSuccess}     
    Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${btnCreateNewRequest}
    SeleniumLibrary.Wait Until Element Is Visible    ${h2NewRequestTicket}
    # Select item
    ${dataIngredient}    Set Variable   xpath: //div[@role='option']/span[text()='${ingredient}']
    Select value from    ${ddlIngredient}    ${dataIngredient}
    # Select Type
    ${dataContractType}    Set Variable    xpath: //div[@role='option']/span[contains(text(),'${contractType}')]
    Select value from    ${ddlContractType}    ${dataContractType}
    # Select Destination
    IF    '${destination}' == 'Lao People Democratic Republic'
        ${dataDestination}    Set Variable   xpath: //div[@role='option' and contains(text(),'Lao People')]
    ELSE
        ${dataDestination}    Set Variable   xpath: //div[@role='option' and text()=' ${destination} ']
    END
    Select value from    ${ddlDestination}    ${dataDestination}
    # Select Due date
    Select value from    ${dateDuedate}    ${date25}
    SeleniumLibrary.Click Element    ${dateDuedate}
    # Create requesst
    SeleniumLibrary.Click Element    ${btnCreateRequest}
    Wait Until Element Is Not Visible   ${loading}
    # Click add new supplier
    SeleniumLibrary.Click Element    ${btnAddSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${txtSupplierFlat}
    # Click supplier
    SeleniumLibrary.Click Element    ${ddlSupplier}
    SeleniumLibrary.Wait Until Element Is Visible    ${li1st}
    SeleniumLibrary.Click Element    ${li1st}
    # Input Spec.
    SeleniumLibrary.Input Text    ${inptSpec}    1000
    # Input QTY
    SeleniumLibrary.Input Text    ${inptQTY}    1000
    # Select Origin
    ${dataOrigin}    Set Variable      xpath: //span[text()='${origin}']//ancestor::div[@role='option']
    Select value from    ${ddlDeparture}    ${dataOrigin}
    # Select Port
    ${dataPort}    Set Variable       xpath: //div[@role='option' and text()=' ANY ']
    Select value from    ${ddlEndpoint}    ${dataPort}
    # Select Sea Frienght
    ${dataSeaFreight}    Set Variable        xpath: //span[text()='${seaFreight}']//ancestor::div[@role='option']
    Select value from    ${ddlSeaFrieght}    ${dataSeaFreight}
    # Shipping start (Fixed as 1 June 2025)
    SeleniumLibrary.Click Element    ${dateShippingStart}
    ${dataShippingStart}    Set Variable   xpath: //ngb-datepicker-month//div[@aria-label='Sunday, June 1, 2025']/div[text()=' 1 ']
    SeleniumLibrary.Click Element    ${dataShippingStart}
    # Shipping End (Fixed as 30 June 2025)
    SeleniumLibrary.Click Element    ${dateShippingEnd}
    ${dataShippingEnd}    Set Variable   xpath: //ngb-datepicker-month//div[@aria-label='Monday, June 30, 2025']/div[text()=' 30 ']
    SeleniumLibrary.Click Element    ${dataShippingEnd}
    # Capture logical
    BuiltIn.Sleep    3s
    SeleniumLibrary.Capture Page Screenshot    RequestTicket_${TEST NAME}_${ingredient}_Origin${origin}_Destination${destination}_.png
    # Input Flat
    SeleniumLibrary.Input Text    ${inptFlat}    1000
    # Input Factory
    SeleniumLibrary.Input Text    ${inptTrasportFee}    25
    # Select Proteitn (Force as Total)
    Select value from    ${ddlCalProtein}    xpath: //span[text()='Total']//ancestor::div[@role='option']
    # Save supplier
    SeleniumLibrary.Click Element    ${btnSave}

    # Input topic
    Set Focus To Element    xpath: //input[@name='topic'] 
    Input Text    xpath: //input[@name='topic']    Test001
    # Input additional info
    Set Focus To Element      xpath: //textarea[@id='additionalInfo']
    Input Text    xpath: //textarea[@id='additionalInfo']    Test001
    Set Focus To Element    xpath: //button[text()=' บันทึกร่าง ']
    Click Element    xpath: //button[text()=' บันทึกร่าง ']
    Wait Until Element Is Not Visible   ${loading}    30s