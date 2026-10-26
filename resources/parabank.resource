*** Settings ***
Library    Browser
Library    String

*** Variables ***
${BASE_URL}    %{PARABANK_URL=https://parabank.parasoft.com/parabank}
${PASSWORD}    DemoPass42!

*** Keywords ***
Start Customer Browser
    New Browser    chromium    headless=True
    New Context
    New Page    ${BASE_URL}/index.htm
    ${unique}=    Evaluate    uuid.uuid4().hex[:18]    modules=uuid
    Set Test Variable    ${USERNAME}    qa${unique}

Fill Registration
    [Arguments]    ${confirmation}=${PASSWORD}
    Click    text=Register
    Fill Text    [id="customer.firstName"]    Automation
    Fill Text    [id="customer.lastName"]    Example
    Fill Text    [id="customer.address.street"]    123 Fictional Street
    Fill Text    [id="customer.address.city"]    Demo City
    Fill Text    [id="customer.address.state"]    CA
    Fill Text    [id="customer.address.zipCode"]    90210
    Fill Text    [id="customer.phoneNumber"]    5551234567
    Fill Text    [id="customer.ssn"]    123456789
    Fill Text    [id="customer.username"]    ${USERNAME}
    Fill Text    [id="customer.password"]    ${PASSWORD}
    Fill Text    id=repeatedPassword    ${confirmation}

Submit Registration
    Click    css=#customerForm input[type=submit]

Register Customer
    Fill Registration
    Submit Registration
    Get Text    css=#rightPanel h1    ==    Welcome ${USERNAME}

Log In
    Fill Text    css=input[name=username]    ${USERNAME}
    Fill Text    css=input[name=password]    ${PASSWORD}
    Click    css=#loginPanel input[type=submit]
