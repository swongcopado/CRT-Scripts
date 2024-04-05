*** Settings ***

Documentation                   New test suite
Library                         QWeb
Library                         DateTime
Library                         String
Suite Setup                     Open Browser                about:blank          chrome
Suite Teardown                  Close All Browsers
*** Variables ***
${email}                        swong@copado.com
${country}                      Australia
${state}                        New South Wales
${postalcode}                   2000



*** Test Cases ***

Creating Developer Edition Trial Org
    GoTo                        https://developer.salesforce.com/signup
    VerifyText                  Sign up for your Salesforce Developer Edition

    Evaluate                    random.seed()               random
    ${exampleFirstName}=        Convert To String           guest1
    ${randomstring}=            Generate Random String      length=3-5           chars=0123456789
    ${FirstName}=               Format String               {}{}                 ${exampleFirstName}    ${randomstring}

    SetConfig                   ShadowDOM                   True
    TypeText                    First Name                  ${FirstName}
    TypeText                    Last Name                   Learner
    TypeText                    Email                       ${email}
    DropDown                    Role                        Developer
    TypeText                    Company Name                Learning Co.
    DropDown                    Country/Region              ${country}
    DropDown                    State/Province              ${state}
    TypeText                    Postal Code                 ${postalcode}
    TypeText                    Username                    ${email}.crttrial
    ClickItem                   eula
    ClickText                   Sign me Up
    VerifyText                  Beep boop processing
    Wait Until Keyword Succeeds                             100s                 10s                    VerifyText                  Please check your email to verify your account.
    SetConfig                   ShadowDOM                   False
