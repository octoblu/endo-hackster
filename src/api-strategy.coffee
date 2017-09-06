_ = require 'lodash'
PassportHackster = require 'passport-hackster'

class HacksterStrategy extends PassportHackster
  constructor: (env) ->
    throw new Error('Missing required environment variable: ENDO_HACKSTER_HACKSTER_CLIENT_ID')     if _.isEmpty process.env.ENDO_HACKSTER_HACKSTER_CLIENT_ID
    throw new Error('Missing required environment variable: ENDO_HACKSTER_HACKSTER_CLIENT_SECRET') if _.isEmpty process.env.ENDO_HACKSTER_HACKSTER_CLIENT_SECRET
    throw new Error('Missing required environment variable: ENDO_HACKSTER_HACKSTER_CALLBACK_URL')  if _.isEmpty process.env.ENDO_HACKSTER_HACKSTER_CALLBACK_URL

    options = {
      clientID:     process.env.ENDO_HACKSTER_HACKSTER_CLIENT_ID
      clientSecret: process.env.ENDO_HACKSTER_HACKSTER_CLIENT_SECRET
      callbackURL:  process.env.ENDO_HACKSTER_HACKSTER_CALLBACK_URL
      scope: 'add_to_toolbox bookmark comment follow profile read_private_project respect write_project'
    }

    super options, @onAuthorization

  onAuthorization: (accessToken, refreshToken, profile, callback) =>
    callback null, {
      id: profile.id
      username: profile.username
      secrets:
        credentials:
          secret: accessToken
          refreshToken: refreshToken
    }

module.exports = HacksterStrategy
