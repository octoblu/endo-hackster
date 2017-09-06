http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class CreateBookmarkList
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.name is required') unless data.name?
    path = "lists"

    @hackster.request 'POST', path, null, data, (error, body) =>
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

module.exports = CreateBookmarkList
