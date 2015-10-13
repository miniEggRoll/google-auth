'use strict'

path            = require 'path'
tokenGen        = require 'firebase-token-generator'
debug           = require('debug')('auth:origin')

{FIREBASE_SECRET} = process.env

tokenGenerator = new tokenGen FIREBASE_SECRET

module.exports = (next)->
    {origin} = @headers
    {hd, email} = @userinfo

    fromBridge = /\/\/bridge\.eztable\.com$/i.test origin
    if fromBridge
        firebase_token = tokenGenerator.createToken {uid: email, hd}
        @body = {firebase_token}
    yield next
