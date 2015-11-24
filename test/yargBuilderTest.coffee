assert = require('assert')
yargsBuilder = require('../src/yargBuilder').default
getMethodInvocation = require('../src/yargBuilder').getMethodInvocation

describe 'yargsBuilder', ->

    it 'returns yargs object', ->
        argv = [ 'foo', 'bar', 'baz' ]
        actual = yargsBuilder({}, argv)
        assert.deepEqual(actual.argv._, argv)
        assert.equal(typeof actual.argv.$0, 'string')


describe 'getMethodInvocation', ->

    it 'accepts alias argument', ->
        spec = { alias: { foo: 'f' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'alias', args: [ 'foo', 'f' ] } ]
        assert.deepEqual(actual, expected)

    it 'accepts multiple alias arguments', ->
        spec = { alias: { foo: 'f', bar: 'b', baz: 'B' } }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'alias', args: [ 'foo', 'f' ] }
            { method: 'alias', args: [ 'bar', 'b' ] }
            { method: 'alias', args: [ 'baz', 'B' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'accepts array argument', ->
        spec = { array: 'foo' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'array', args: [ 'foo' ] } ]
        assert.deepEqual(actual, expected)

    it 'accepts multiple array arguments', ->
        spec = { array: [ 'foo', 'bar', 'baz' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'array', args: [ 'foo' ] }
            { method: 'array', args: [ 'bar' ] }
            { method: 'array', args: [ 'baz' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'accepts multiple boolean arguments', ->
        spec = { boolean: [ 'foo', 'bar', 'baz' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'boolean', args: [ 'foo' ] }
            { method: 'boolean', args: [ 'bar' ] }
            { method: 'boolean', args: [ 'baz' ] }
        ]
        assert.deepEqual(actual, expected)

    it '.check(fn)', ->
        fn = -> console.log('checking!')
        spec = { check: fn }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'check', args: [ fn ] } ]
        assert.deepEqual(actual, expected)

    it 'accepts multiple choices arguments', ->
        spec = { choices: { foo: [ 'apples', 'oranges' ], bar: [ 'peaches', 'pears' ], baz: [ 'plums', 'mangos', 'guava' ] } }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'choices', args: [ 'foo', [ 'apples', 'oranges' ] ] }
            { method: 'choices', args: [ 'bar', [ 'peaches', 'pears' ] ] }
            { method: 'choices', args: [ 'baz', [ 'plums', 'mangos', 'guava' ] ] }
        ]
        assert.deepEqual(actual, expected)

    it '.command(cmd, desc, [fn])'

    it '.completion(cmd, [description], [fn])'

    it '.config(key)', ->
        spec = { config: '~/.foo.conf' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'config', args: [ '~/.foo.conf' ] } ]
        assert.deepEqual(actual, expected)

    it '.config(key, [description])', ->
        spec = { config: '~/.foo.conf' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'config', args: [ '~/.foo.conf' ] } ]
        assert.deepEqual(actual, expected)

    it '.count(key)', ->
        spec = { count: [ 'foo', 'bar', 'baz' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'count', args: [ 'foo' ] }
            { method: 'count', args: [ 'bar' ] }
            { method: 'count', args: [ 'baz' ] }
        ]
        assert.deepEqual(actual, expected)

    it '.default(key, value)', ->
        spec = { default: { foo: 'bar' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'default', args: [ 'foo', 'bar' ] } ]
        assert.deepEqual(actual, expected)

    it '.default(key, value, [description])'

    it '.demand(key, [msg | boolean])'

    it '.demand(count, [max], [msg])'

    it '.describe(key, desc)', ->
        spec = { describe: { foo: 'foo is awesome' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'describe', args: [ 'foo', 'foo is awesome' ] } ]
        assert.deepEqual(actual, expected)

    it '.detectLocale(boolean)', ->
        spec = { detectLocale: true }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'detectLocale', args: [ true ] } ]
        assert.deepEqual(actual, expected)

    it '.epilogue(str)', ->
        spec = { epilogue: 'foo bar baz' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'epilogue', args: [ 'foo bar baz' ] } ]
        assert.deepEqual(actual, expected)

    it '.epilog(str)', ->
        spec = { epilog: 'foo bar baz' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'epilog', args: [ 'foo bar baz' ] } ]
        assert.deepEqual(actual, expected)

    it '.example(cmd, desc)'

    it '.exitProcess(enable)', ->
        spec = { exitProcess: true }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'exitProcess', args: [ true ] } ]
        assert.deepEqual(actual, expected)

    it '.fail(fn)', ->
        fn = -> console.log('fail')
        spec = { fail: fn }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'fail', args: [ fn ] } ]
        assert.deepEqual(actual, expected)

    it '.help([option, [description]])'

    it '.implies(x, y)', ->
        spec = { implies: { x: 'y' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'implies', args: [ 'x', 'y' ] } ]
        assert.deepEqual(actual, expected)


    it '.locale(locale)', ->
        spec = { locale: 'pirate' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'locale', args: [ 'pirate' ] } ]
        assert.deepEqual(actual, expected)

    it '.nargs(key, count)'

    it '.options(key, opt)', ->
        spec = { options: [ { name: 'foo', alias: 'f', type: 'boolean' } ] }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'options', args: [ 'foo', { alias: 'f', type: 'boolean' } ] } ]
        assert.deepEqual(actual, expected)

    it '.require(key)', ->
        spec = { require: 'foo' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'require', args: [ 'foo' ] } ]
        assert.deepEqual(actual, expected)

    it '.require(key, [msg | boolean])', ->
        spec = { require: { foo: false } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'require', args: [ 'foo', false ] } ]
        assert.deepEqual(actual, expected)

    it '.required(key)', ->
        spec = { required: 'foo' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'required', args: [ 'foo' ] } ]
        assert.deepEqual(actual, expected)

    it '.required(key, [msg | boolean])', ->
        spec = { required: { foo: false } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'required', args: [ 'foo', false ] } ]
        assert.deepEqual(actual, expected)

    it '.showHelp(consoleLevel="error")', ->
        spec = { showHelp: 'log' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'showHelp', args: [ 'log' ] } ]
        assert.deepEqual(actual, expected)

    it '.showHelpOnFail(enable)', ->
        spec = { showHelpOnFail: true }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'showHelpOnFail', args: [ true ] } ]
        assert.deepEqual(actual, expected)

    it '.showHelpOnFail(enable, message)', ->
        spec = { showHelpOnFail: { condition: false, message: 'to show help use --help' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'showHelpOnFail', args: [ false, 'to show help use --help' ] } ]
        assert.deepEqual(actual, expected)

