*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                            https://automate-test.stpb-digital.com/register/
${Browser}                        gc
${locator_firstname}              id=firstname
${locator_lastname}               id=lastname
${locator_email}                  id=email
${locator_password}               id=password
${locator_phone}                  id=mobile-phone
${locator_gender}                 validation-basic-radio
${locator_chkboxsql}              name=courses.SQL
${locator_chkboxmanual}           name=courses.Test Manual
${locator_chkboxauto}             name=courses.Automate Test
${locator_chkboxauto2}            name=courses.Automate Test2
${locator_nationality}            id=nationality
${locator_nationality_thai}       xpath=//*[@id="menu-"]/div[3]/ul/li[221]
${locator_select_role}            id=select-role
${locator_select_role_admin}      xpath=//*[@id="menu-"]/div[3]/ul/li[1]
${locator_select_role_editor}     xpath=//*[@id="menu-"]/div[3]/ul/li[3]
${locator_plan}                   id=select-plan
${locator_plan_basic}             xpath=//*[@id="menu-"]/div[3]/ul/li[1]
${locator_sign_up}                id=btn-sign-up
${locator_reset}                  id=reset

# Negative Case
${locator_error_firstname}        id=error-firstname
${locator_error_lastname}         id=error-lastname
${locator_error_email}            id=error-email
${locator_error_password}         id=error-password
${locator_error_phone}            id=error-mobile-phone
${locator_error_gender}           id=validation-basic-gender
${locator_error_course}           id=validation-basic-courses
${locator_error_nationality}      id=validation-basic-nationality
${locator_error_role}             id=validation-role
${locator_error_plan}             id=validation-plan


*** Keywords ***
Open Web Browser
    Set Selenium Speed    0.2
    Open Browser    ${URL}    ${Browser}
    Wait Until Page Contains    Kru P' Beam    3s
    Maximize Browser Window

Input Data For REG
    Input Text    ${locator_firstname}    Chanisara
    Input Text    ${locator_lastname}    Ruyuenyong
    Input Text    ${locator_email}    Beam1234@gmail.com
    Input Text    ${locator_password}    1234567890
    Input Text    ${locator_phone}    08222222222
    Select Radio Button    ${locator_gender}    female
    Select Checkbox    ${locator_chkboxauto}
    Select Nationality
    Select Role
    Select Plan
    

Select Nationality
    Click Element    ${locator_nationality}
    Wait Until Element Is Visible    ${locator_nationality_thai}    3s
    Click Element    ${locator_nationality_thai}

Select Role
    Click Element    ${locator_select_role}
    Wait Until Element Is Visible    ${locator_select_role_admin}    3s
    Click Element    ${locator_select_role_editor}

Select Plan
    Click Element    ${locator_plan}
    Wait Until Element Is Visible    ${locator_plan_basic}    3s
    Click Element    ${locator_plan_basic}

Input Data For REG Email Invalid Format @
    Input Text    ${locator_email}    Beam1234gmail.com
    Click Element    ${locator_sign_up}
    ${txt}    Get Text    ${locator_error_email}
    Should Be Equal As Strings   ${txt}    Invalid email address

Input Data For REG Email Invalid Format Thai
    Input Text    ${locator_email}    ไทย
    Click Element    ${locator_sign_up}
    ${txt}    Get Text    ${locator_error_email}
    Should Be Equal As Strings   ${txt}    Invalid email address
    

Input Data For REG Email Invalid Format Number
    Input Text    ${locator_email}    09912345678
    Click Element    ${locator_sign_up}
    ${txt}    Get Text    ${locator_error_email}
    Should Be Equal As Strings   ${txt}    Invalid email address

Not Input Data For REG
    Click Element    ${locator_sign_up}
    ${txt}    Get Text    ${locator_error_firstname}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_lastname}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_email}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_password}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_phone}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_gender}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_course}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_nationality}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_role}
    Should Be Equal As Strings   ${txt}    This field is required
    ${txt}    Get Text    ${locator_error_plan}
    Should Be Equal As Strings   ${txt}    This field is required

*** Test Cases ***
TC001-REG Input Data
    Open Web Browser
    Input Data For REG
    Click Element    ${locator_sign_up}
    Wait Until Page Contains    Register Success
    Click Element    id=btn-ok
    Wait Until Page Contains    Welcome to Kru P' Beam! 👋🏻
    Close Browser

TC002-REG Not Input Data
    Open Web Browser
    Not Input Data For REG
    Close Browser

TC003-REG Input Data Email Invalid Format @
    Open Web Browser
    Input Data For REG Email Invalid Format @
    Close Browser

TC003-REG Input Data Email Invalid Format Thai
    Open Web Browser
    Input Data For REG Email Invalid Format Thai
    Close Browser

TC003-REG Input Data Email Invalid Format Number
    Open Web Browser
    Input Data For REG Email Invalid Format Number
    Close Browser

TC004-Reset Data
    Open Web Browser
    Input Data For REG
    Click Element    ${locator_reset}
    Close Browser

