http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class DeleteBookmark
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.listId is required') unless data.listId?
    return callback @_userError(422, 'data.projectId is required') unless data.projectId?
    path = "lists/#{data.listId}/projects"

    @hackster.request 'DELETE', path, null, { project_id: data.projectId }, (error) =>
      return callback error if error?
      return callback null, {
        metadata:
          code: 200
          status: http.STATUS_CODES[200]
      }

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = DeleteBookmark
