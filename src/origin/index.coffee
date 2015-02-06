'use strict'

path    = require 'path'
glob    = require 'glob'
compose = require 'koa-compose'

mw = glob
.sync("#{__dirname}/*")
.filter (p) ->
    p isnt __filename

mw.forEach (p) ->
    ext = path.extname p
    n = path.basename p, ext
    exports[n] = require(p)

exports.compose = ->
    compose mw.map (p) ->
        require(p)
