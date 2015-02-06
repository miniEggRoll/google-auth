'use strict'

path            = require 'path'
https           = require 'https'
debug           = require('debug')('auth:auth')

{hd} = process.env

module.exports = (next)->
    @throw 401, 'Unauthorized account' unless @userinfo.hd is hd
    yield next
