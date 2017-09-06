http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class PostComment
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.projectId is required') unless data.projectId?
    return callback @_userError(422, 'data.md_body is required') unless data.md_body?

    path = "projects/#{data.projectId}/comments"
    body = { md_body: data.md_body }

    @hackster.request 'POST', path, null, null, (error, body) =>
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

module.exports = PostComment
