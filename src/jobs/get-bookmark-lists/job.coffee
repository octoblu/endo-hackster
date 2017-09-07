http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class GetBookmarkLists
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>

    path = "lists"
    qs = {}
    if data?
      qs.project_id = data.project_id if data.project_id?

    @hackster.request 'GET', path, qs, null, (error, body) =>
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

module.exports = GetBookmarkLists
