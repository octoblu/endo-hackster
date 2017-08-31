HacksterRequest = require './hackster-request'

class RefreshTokenHandler
  constructor: ({}) ->
    @hackster = new HacksterRequest

  isTokenValid: (callback) =>
    callback null


module.exports = RefreshTokenHandler
