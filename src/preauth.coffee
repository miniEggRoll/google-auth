'use strict'

module.exports = (next)->
    @throw 405 unless @method in ['POST', 'OPTIONS']
    @set 'Access-Control-Allow-Origin', '*'
    @set 'Access-Control-Allow-Methods', 'POST, OPTIONS'
    @set 'Access-Control-Allow-Headers', 'content-type'
    return @status = 200 if @method is "OPTIONS"
    yield next
    @status = 204 unless @body?
