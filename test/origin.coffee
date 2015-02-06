'use strict'

path        = require 'path'
{assert}    = require 'chai'
koa         = require 'koa'
_           = require 'underscore'
request     = require 'supertest'
debug       = require('debug')('test:origin')

error       = require path.join(__dirname, '../src/error')
preauth     = require path.join(__dirname, '../src/preauth')
auth        = require path.join(__dirname, '../src/auth')
userinfo    = require path.join(__dirname, '../src/userinfo')
o           = require path.join(__dirname, '../src/origin')


describe 'origin', ->
    it 'give foo/bar if no origin matched', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use (next)->
            @userinfo = {email: 'test', hd: 'eztable.com'}
            yield next
        app.use userinfo
        app.use o.demo

        request app.listen()
        .post '/'
        .set 'googleAccessToken', 'asdfsadfasfsd'
        .expect '{"foo":"bar"}', done


    it 'give firebase token if host is from bridge.eztable.com', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use (next)->
            @userinfo = {email: 'test', hd: 'eztable.com'}
            yield next
        app.use userinfo
        app.use o.bridge

        request app.listen()
        .post '/'
        .set 'host', 'bridge.eztable.com'
        .set 'googleAccessToken', 'asdfsadfasfsd'
        .end (err, res)->
            assert.property res.body, 'firebase_token'
            done()  

    it 'give firebase token if origin is from http://bridge.eztable.com', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use (next)->
            @userinfo = {email: 'test', hd: 'eztable.com'}
            yield next
        app.use userinfo
        app.use o.bridge

        request app.listen()
        .post '/'
        .set 'origin', 'http://bridge.eztable.com'
        .set 'googleAccessToken', 'asdfsadfasfsd'
        .end (err, res)->
            assert.property res.body, 'firebase_token'
            done()

    it 'give firebase token if origin is from https://bridge.eztable.com', (done)->
        app = koa()
        app.use error
        app.use preauth
        app.use (next)->
            @userinfo = {email: 'test', hd: 'eztable.com'}
            yield next
        app.use userinfo
        app.use o.bridge

        request app.listen()
        .post '/'
        .set 'origin', 'https://bridge.eztable.com'
        .set 'googleAccessToken', 'asdfsadfasfsd'
        .end (err, res)->
            assert.property res.body, 'firebase_token'
            done()
