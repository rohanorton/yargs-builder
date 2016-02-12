Yarg Builder
============

Yargs is a fantastic module, but I'm not a fan of chaining lots of methods
together. This is essentially a wrapper to make it possible to get all the
piratey goodness of yargs but in a more declarative manner.

Here's a quick example cribbed from the yargs module itself

line_count.js
```js
#!/usr/bin/env node
var yargBuilder = require('yargBuilder');
var argv = yargBuilder({
    usage: 'Usage: $0 <command> [options]',
    command: { count: 'Count the lines in a file' },
    example: { '$0 count -f foo.js': 'count the lines in the given file' },
    options: {
        f: { demand: true, nargs: 1, alias: 'file', describe: 'Load a file' }
    },
    help: 'h',
    alias: { h: 'help' },
    epilog: 'Borrowed from Yargs, Copyright 2015'
}).argv;

var fs = require('fs');
var s = fs.createReadStream(argv.file);

var lines = 0;
s.on('data', function (buf) {
    lines += buf.toString().match(/\n/g).length;
});

s.on('end', function () {
    console.log(lines);
});
```

```bash
$ node line_count.js count
Usage: line_count.js <command> [options]

Commands:
  count    Count the lines in a file

Options:
  -f, --file  Load a file        [required]
  -h, --help  Show help           [boolean]

Examples:
  line_count.js count -f foo.js  count the lines in the given file

Borrowed from Yargs, Copyright 2015

Missing required arguments: f

$ node line_count.js count --file line_count.js
26

$ node line_count.js count -f line_count.js
26
```
