#
#  Email set up.  Not happy about the password here....
#

process.env.MAIL_URL = "smtp://" + encodeURIComponent('no_reply@pfafman.com') + ':' +
    encodeURIComponent('rf7-34e-61s-sDK') + "@smtp.googlemail.com:465"
