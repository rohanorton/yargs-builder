assert = require('assert')
sinon = require('sinon')
yargBuilder = require('../src/yargBuilder').default

methods = { myMethod: -> this }
yargs = -> methods

beforeEach ->
    sinon.spy(methods, 'myMethod')

afterEach ->
    methods.myMethod.restore()

describe 'yargBuilder', ->

    it 'returns yargs object', ->
        argv = [ 'foo', 'bar', 'baz' ]
        actual = yargBuilder({}, argv)
        assert.deepEqual(actual.argv._, argv)
        assert.equal(typeof actual.argv.$0, 'string')

    it 'calls specified methods on yargs with correct args', ->
        sinon.spy(yargs)
        spec = { myMethod: { foo: [ 'apples', 'oranges' ] } }
        yargBuilder(spec, [], yargs)
        assert(methods.myMethod.calledWithExactly('foo', [ 'apples', 'oranges' ]))

    it 'calls specified methods on yargs', ->
        sinon.spy(yargs)
        spec = { myMethod: { foo: [ 'apples', 'oranges' ], bar: [ 'peaches', 'pears' ], baz: [ 'plums', 'mangos', 'guava' ] } }
        yargBuilder(spec, [], yargs)
        assert.equal(methods.myMethod.callCount, 3)

    it 'thows if no yargs method', ->
        spec = { asdfsadf: 'this is a missing method' }
        fn = -> yargBuilder(spec, [])
        assert.throws(fn, /Yargs does not have method asdfsadf/)
