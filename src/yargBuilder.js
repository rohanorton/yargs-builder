import Yargs from 'yargs';
import { map, reduce, isPlainObject, omit, has } from 'lodash';

let toArray = (x) => [].concat(x);

let objectToArgs = (method, obj) =>
    map(obj, (val, key) => ({ method, args: [ key, val ] }))

let valsToArgs = (method, vals) =>
    map(toArray(vals), (val) => ({ method, args: [ val ] }))

let toOptionsArgs = (method, vals) =>
    map(toArray(vals), (val) => ({ method, args: [ val.name, omit(val, 'name') ]}));

let isConditional = (obj) =>
    isPlainObject(obj) && has(obj, 'condition') && has(obj, 'message');

let toConditionalArgs = (method, { condition, message }) =>
    ({ method, args: [ condition, message ] })

let createArgs = (key, val) => {
    if (key === 'options')  return toOptionsArgs(key, val);
    if (isConditional(val)) return toConditionalArgs(key, val);
    if (isPlainObject(val)) return objectToArgs(key, val);
    /* default */           return valsToArgs(key, val);
}

let collectArgs = (coll, val, key) =>
    coll.concat(createArgs(key, val));

let getMethodInvocation = (spec) =>
    reduce(spec, collectArgs, []);

let invoke = (fn) =>
    ({ method, args }) =>
        fn[method](...args)

let yargBuilder = (spec = {}, argv = process.argv.slice(2), yargs = Yargs) =>
    reduce(getMethodInvocation(spec),
           invoke(yargs),
           yargs(argv));

export default yargBuilder;
export { getMethodInvocation };
