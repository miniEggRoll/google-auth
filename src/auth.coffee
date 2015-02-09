'use strict'

path            = require 'path'
https           = require 'https'
debug           = require('debug')('auth:auth')

getData = (reqOpt)->
    (done)->
        emailReq = https.request reqOpt, (res)->
            result = ''
            res.on 'data', (chunk)->
                result += chunk.toString()
            res.on 'end', ->
                if res.statusCode is 200 then done null, JSON.parse result
                else done new Error(result)

        emailReq.on 'error', (e)->
            done e
        do emailReq.end

module.exports = (next)->
    token = @request.body.googleAccessToken
    reqOpt =
        hostname: 'www.googleapis.com'
        path: "/oauth2/v2/userinfo"
        method: 'GET'
        headers:
            Authorization: "Bearer #{token}"
    try
        @userinfo = yield getData reqOpt
    catch e
        @throw 401, e.message

    yield next
