_ = require 'underscore'

module.exports = (next)->
    try
        yield next
    catch e
        @status = +e.statusCode if _.isFinite +e.statusCode
