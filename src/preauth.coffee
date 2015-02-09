'use strict'

module.exports = (next)->
    @throw 405 unless @method in ['POST', 'OPTIONS']
    @set 'Access-Control-Allow-Origin', @get 'origin'
    yield next
    @status = 204 unless @body?
