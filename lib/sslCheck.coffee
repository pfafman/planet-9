
###
@IsSSL     = true
@IsPrivate = false

if Meteor.isClient
  Meteor.startup ->
    console.log("call getSSL")
    Meteor.call "getSSL", (error, rtn) ->
      console.log('getSSL:',rtn)


if Meteor.isServer
  
  httpServer = WebApp.httpServer
  oldHttpServerListeners = httpServer.listeners("request").slice(0)
  httpServer.removeAllListeners "request"
  httpServer.addListener "request", (req, res) =>
    remoteAddress = req.connection.remoteAddress or req.socket.remoteAddress

    @IsPrivate = (isPrivateAddress(remoteAddress) and (not req.headers["x-forwarded-for"] or _.all(req.headers["x-forwarded-for"].split(","), (x) ->
      isPrivateAddress x
    )))

    @IsSSL = req.connection.pair or (req.headers["x-forwarded-proto"] and req.headers["x-forwarded-proto"].indexOf("https") isnt -1)

    if @IsSSL
      console.log("Connection is Secure", @IsSSL, @IsPrivate)
    else
      console.log("Connection is not Secure", @IsSSL, @IsPrivate)
    
    args = arguments
    _.each oldHttpServerListeners, (oldListener) ->
      oldListener.apply httpServer, args
      return

    return


  @isPrivateAddress = (address) ->
    console.log("isPrivateAddress", address)
    return true if /^\s*(127\.0\.0\.1|::1)\s*$/.test address
    return true if /^\s*(10\.\d+\.\d+\.\d+)\s*$/.test address
    return true if /^\s*(192\.168\.\d+\.\d+)\s*$/.test address
    return true if /^\s*(172\.(1[6-9]|2[0-9]|3[01])\.\d+\.\d+)\s*$/.test address
    return false


Meteor.methods
  "getSSL": ->
    console.log('getSSL', @IsSSL, @IsPrivate)
    rtn =
      ssl: @IsSSL
      private: @IsPrivate

###
