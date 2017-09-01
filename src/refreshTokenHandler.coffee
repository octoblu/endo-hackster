HacksterRequest = require './hackster-request'
jwtDecode = require 'jwt-decode'
moment    = require 'moment'

class RefreshTokenHandler
  constructor: () ->
    @hackster = new HacksterRequest

  isTokenValid: ({credentials}, callback) =>
    decoded = jwtDecode credentials.secret
    { exp } = decoded
    now = moment().utc()
    expiration = moment(exp)
    isValid = now.isBefore(expiration)
    callback null, isValid

  refreshToken: (secrets, callback) =>
    refresh_token = secrets.credentials.refreshToken
    @hackster.refreshToken refresh_token, (error, body) =>
      return callback error if error?
      credentials = {
        secret: body.access_token
        refreshToken: body.refresh_token
      }
      secrets.credentials = credentials
      return callback null, secrets


module.exports = RefreshTokenHandler
