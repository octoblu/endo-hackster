http   = require 'http'
_      = require 'lodash'
HacksterRequest = require '../../hackster-request'

class DeleteProduct
  constructor: ({@encrypted}) ->
    accessToken =  @encrypted.secrets.credentials.secret
    @hackster = new HacksterRequest
    @hackster.setToken accessToken

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.productId is required') unless data.productId?
    path = "products/#{data.productId}"

    @hackster.request 'DELETE', path, null, null, (error) =>
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

module.exports = DeleteProduct
