Accounts.config
    sendVerificationEmail: true

Accounts.emailTemplates.siteName = "Test 9"
Accounts.emailTemplates.from = "tim <tim@pfafman.com>"


Accounts.emailTemplates.verifyEmail.subject = (user) ->
    "Welcome to Test 9.  Please verify your email"

Accounts.emailTemplates.verifyEmail.text = (user, url) ->
    """
    Hello,

    To verify your account email, simply click the link below.

    #{url}    

    If you have questions please email us at tim@pfafman.com.

    Thanks,
        Tim
    """


Accounts.onCreateUser (options, user) ->
    email = user.emails[0].address
    console.log("onCreateUser", email)
    Email.send
        to: "tim@pfafman.com"
        from: "tim@pfafman.com"
        subject: "New Account"
        text: "New account created for #{email}"

    if options.profile
        user.profile = options.profile
    user
