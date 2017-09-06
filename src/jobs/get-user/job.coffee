http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class GetUser
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.userId is required') unless data.userId?

    path = "users/#{data.userId}"

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

module.exports = GetUser
