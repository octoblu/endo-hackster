http   = require 'http'
_      = require 'lodash'

class ListEventsByUser
  constructor: ({@encrypted}) ->
    # @github = new Github
    #   debug: true
    # @github.authenticate type: 'oauth', token: @encrypted.secrets.credentials.secret


  do: ({data}, callback) =>
    # return callback @_userError(422, 'data.username is required') unless data.username?
    #
    # @github.activity.getEventsForUser {user: data.username}, (error, results) =>
    #   return callback error if error?
    #   return callback null, {
    #     metadata:
    #       code: 200
    #       status: http.STATUS_CODES[200]
    #     data: @_processResults results
    #   }
    return callback null


  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = ListEventsByUser
