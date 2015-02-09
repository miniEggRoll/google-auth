'use strict'

http        = require 'http'
path        = require 'path'
debug       = require('debug')('auth:index')
koa         = require 'koa'
bodyParser  = require 'koa-body-parser'
_           = require 'underscore'

error       = require path.join(__dirname, 'error')
preauth     = require path.join(__dirname, 'preauth')
auth        = require path.join(__dirname, 'auth')
userinfo    = require path.join(__dirname, 'userinfo')
origin      = require path.join(__dirname, 'origin')

{PORT} = process.env

app = koa()

app.use error
app.use bodyParser()
app.use preauth
app.use auth
app.use userinfo

app.use origin.compose()

http.createServer app.callback()
.listen PORT, -> console.log "hosting auth on #{PORT}"
