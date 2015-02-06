'use strict'

path            = require 'path'
https           = require 'https'
debug           = require('debug')('auth:origin')

module.exports = (next)->
    yield next
    @body = {foo:'bar'} unless @body?
