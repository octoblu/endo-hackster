http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class GetChannelDetails
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.channelId is required') unless data.channelId?

    path = "channels/#{data.channelId}"

    @hackster.request 'GET', path, null, null, (error, body) =>
      return callback error if error?
      return callback null, {
        metadata:
          code: 200
          status: http.STATUS_CODES[200]
        data: body
      }

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = GetChannelDetails
