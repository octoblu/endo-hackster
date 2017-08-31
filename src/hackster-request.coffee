request = require 'request'

class HacksterRequest
  constructor: ({accessToken}) ->
    @base_uri = 'https://api.hackster.io/v2/'
    @access_token = accessToken if accessToken?

  request: (method, path, qs, body, callback) =>
    options = {
      uri: @base_uri + path
      method: method
      headers: {}
      json: true
    }

    options.headers['Authorization'] = 'Bearer ' + @access_token if @access_token?
    options.qs = qs if qs?
    options.body = body if body?

    request options, (error, res, body) =>
      callback error, body

  refreshToken: (refreshToken, clientId, clientSecret, callback) =>
    options = {
      uri: 'https://www.hackster.io/oauth/token'
      method: 'POST'
      json: true
      qs:
        refresh_token: refreshToken
        client_id: clientId
        client_secret: clientSecret
        grant_type: 'refresh_token'
    }

    request options, (error, res, body) =>
      return callback error, body


module.exports = HacksterRequest
