// var argv = require('yargs')
//     .count('verbose')
//     .alias('v', 'verbose')
//     .argv;
//
var yargs = require('yargs');
yargs.option('foo', {
    alias: 'f',
    type: 'string',
    nargs: 2
})
var argv = yargs(['--foo', 'bar', 'baz', 'qux']).argv;

console.log(argv);

