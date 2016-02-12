assert = require('assert')
getMethodInvocation = require('../src/yargBuilder').getMethodInvocation

###
# These tests are pretty repetitive and many of them duplicate test of
# underlying functionality, however it seems like a good idea to use the tests
# to document which of yargs' methods are supported by yarg builder.
###

describe 'getMethodInvocation', ->

    it 'calls .alias(key, alias)', ->
        spec = { alias: { foo: 'f', bar: 'b', baz: 'B' } }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'alias', args: [ 'foo', 'f' ] }
            { method: 'alias', args: [ 'bar', 'b' ] }
            { method: 'alias', args: [ 'baz', 'B' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'calls .array(key)', ->
        spec = { array: [ 'foo', 'bar', 'baz' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'array', args: [ 'foo' ] }
            { method: 'array', args: [ 'bar' ] }
            { method: 'array', args: [ 'baz' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'calls .boolean(key)', ->
        spec = { boolean: [ 'foo', 'bar', 'baz' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'boolean', args: [ 'foo' ] }
            { method: 'boolean', args: [ 'bar' ] }
            { method: 'boolean', args: [ 'baz' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'calls .check(fn)', ->
        fn = -> console.log('checking!')
        spec = { check: fn }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'check', args: [ fn ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .choices(key, choices)', ->
        spec = { choices: { foo: [ 'apples', 'oranges' ], bar: [ 'peaches', 'pears' ], baz: [ 'plums', 'mangos', 'guava' ] } }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'choices', args: [ 'foo', [ 'apples', 'oranges' ] ] }
            { method: 'choices', args: [ 'bar', [ 'peaches', 'pears' ] ] }
            { method: 'choices', args: [ 'baz', [ 'plums', 'mangos', 'guava' ] ] }
        ]
        assert.deepEqual(actual, expected)

    it 'calls .command(cmd, desc)'
    it 'calls .command(cmd, desc, fn)'
    it 'calls .completion(cmd, [description], [fn])'

    it 'calls .config(key)', ->
        spec = { config: 'foo' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'config', args: [ 'foo' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .config(key, description)', ->
        spec = { config: { foo: 'description' }}
        actual = getMethodInvocation(spec)
        expected = [ { method: 'config', args: [ 'foo', 'description' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .count(key)', ->
        spec = { count: [ 'foo', 'bar', 'baz' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'count', args: [ 'foo' ] }
            { method: 'count', args: [ 'bar' ] }
            { method: 'count', args: [ 'baz' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'calls .default(key, value)', ->
        spec = { default: { foo: 'bar' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'default', args: [ 'foo', 'bar' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .default(key, value, description)'

    it 'calls .demand(key)', ->
        spec = { demand: [ 'foo', 'bar' ] }
        actual = getMethodInvocation(spec)
        expected = [
            { method: 'demand', args: [ 'foo' ] }
            { method: 'demand', args: [ 'bar' ] }
        ]
        assert.deepEqual(actual, expected)

    it 'calls .demand(key, [msg | boolean])', ->
        spec = { demand: { foo: 'bar' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'demand', args: [ 'foo', 'bar' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .demand(count, [max], [msg])'

    it 'calls .describe(key, desc)', ->
        spec = { describe: { foo: 'foo is awesome' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'describe', args: [ 'foo', 'foo is awesome' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .detectLocale(boolean)', ->
        spec = { detectLocale: true }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'detectLocale', args: [ true ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .epilogue(str)', ->
        spec = { epilogue: 'foo bar baz' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'epilogue', args: [ 'foo bar baz' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .epilog(str)', ->
        spec = { epilog: 'foo bar baz' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'epilog', args: [ 'foo bar baz' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .example(cmd, desc)', ->
        spec = { example: { foo: 'This is a command that does things and stuff' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'example', args: [ 'foo', 'This is a command that does things and stuff' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .exitProcess(enable)', ->
        spec = { exitProcess: true }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'exitProcess', args: [ true ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .fail(fn)', ->
        fn = -> console.log('fail')
        spec = { fail: fn }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'fail', args: [ fn ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .help([option, [description]])'

    it 'calls .implies(x, y)', ->
        spec = { implies: { x: 'y' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'implies', args: [ 'x', 'y' ] } ]
        assert.deepEqual(actual, expected)


    it 'calls .locale(locale)', ->
        spec = { locale: 'pirate' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'locale', args: [ 'pirate' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .nargs(key, count)', ->
        spec = { nargs: { foo: 7 } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'nargs', args: [ 'foo', 7 ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .options(key, opt)', ->
        spec = { options: { foo: { alias: 'f', type: 'boolean' } } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'options', args: [ 'foo', { alias: 'f', type: 'boolean' } ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .require(key)', ->
        spec = { require: 'foo' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'require', args: [ 'foo' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .require(key, [msg | boolean])', ->
        spec = { require: { foo: false } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'require', args: [ 'foo', false ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .required(key)', ->
        spec = { required: 'foo' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'required', args: [ 'foo' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .required(key, [msg | boolean])', ->
        spec = { required: { foo: false } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'required', args: [ 'foo', false ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .showHelp(consoleLevel="error")', ->
        spec = { showHelp: 'log' }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'showHelp', args: [ 'log' ] } ]
        assert.deepEqual(actual, expected)

    it 'calls .showHelpOnFail(enable)', ->
        spec = { showHelpOnFail: true }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'showHelpOnFail', args: [ true ] } ]
        assert.deepEqual(actual, expected)

    it '.showHelpOnFail(enable, message)', ->
        spec = { showHelpOnFail: { condition: false, message: 'to show help use --help' } }
        actual = getMethodInvocation(spec)
        expected = [ { method: 'showHelpOnFail', args: [ false, 'to show help use --help' ] } ]
        assert.deepEqual(actual, expected)
