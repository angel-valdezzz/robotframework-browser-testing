*** Settings ***
Resource    ../resources/parabank.resource
Test Setup    Start Customer Browser
Test Teardown    Close Browser    ALL

*** Test Cases ***
Register A New Customer
    Register Customer

Logout And Login
    Register Customer
    Click    text=Log Out
    Log In
    Get Text    css=#rightPanel h1    ==    Accounts Overview

Required Fields
    Click    text=Register
    Submit Registration
    Get Text    [id="customer.firstName.errors"]    ==    First name is required.

Reject Mismatched Passwords
    Fill Registration    Different42!
    Submit Registration
    Get Text    [id="repeatedPassword.errors"]    ==    Passwords did not match.

Reject Unknown Customer
    Log In
    Get Text    css=#rightPanel .error    ==    The username and password could not be verified.

Open A Savings Account
    Register Customer
    Click    text=Open New Account
    Wait For Elements State    css=#fromAccountId option    attached
    Select Options By    id=type    value    1
    Click    css=#openAccountForm input.button
    ${id}=    Get Text    id=newAccountId    matches    ^\d+$
    Click    id=newAccountId
    Get Text    id=accountId    ==    ${id}
    Get Text    id=accountType    ==    SAVINGS
