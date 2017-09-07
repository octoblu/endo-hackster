http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class GetChannels
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    # return callback @_userError(422, 'data.question_id is required') unless data.question_id?

    path = 'channels'
    qs = {}

    if data?
      qs.per_page = data.per_page if data.per_page?
      qs.page = data.page if data.page?
      qs.sort = data['sort'] unless data.q?
      qs.type = data.type if data.type?
      qs.q = data.q if data.q?
      qs.approved = data.approved unless data.q?

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

module.exports = GetChannels
