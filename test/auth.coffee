'use strict'

path        = require 'path'
qs          = require 'querystring'
https       = require 'https'
koa         = require 'koa'
request     = require 'supertest'
_           = require 'underscore'
error       = require path.join(__dirname, '../src/error')
preauth     = require path.join(__dirname, '../src/preauth')
auth        = require path.join(__dirname, '../src/auth')
userinfo    = require path.join(__dirname, '../src/userinfo')
o           = require path.join(__dirname, '../src/origin')

describe 'preauth', ->
    it 'only accept post method', (done)->
        app = koa()

        app.use error
        app.use preauth
        app.use auth

        request app.listen()
        .get '/'
        .expect 405, done

    it 'return 401 if google token is not assigned', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use auth

        request app.listen()
        .post '/'
        .expect 401, done

    it 'return 401 if google token is not valid', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use auth

        request app.listen()
        .post '/'
        .set 'googleAccessToken', 'asdfasdfsa'
        .expect 401, done

    it 'return 401 if google token does not give right hd', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use (next)->
            @userinfo = {email: 'test', hd: 'test'}
            yield next
        app.use userinfo

        request app.listen()
        .post '/'
        .set 'googleAccessToken', ''
        .expect 401, done

    it 'return 204 if google token is valid', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use (next)->
            @userinfo = {email: 'test', hd: 'eztable.com'}
            yield next
        app.use userinfo

        request app.listen()
        .post '/'
        .set 'googleAccessToken', ''
        .expect 204, done
