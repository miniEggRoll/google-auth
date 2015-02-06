'use strict'

module.exports = (next)->
    @throw 405 unless @method is 'POST'
    @set {'Access-Control-Allow-Origin': @headers.origin}
    yield next
    @status = 204 unless @body?
