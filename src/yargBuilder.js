import Yargs from 'yargs';
import { map, reduce, isPlainObject, has } from 'lodash';
import assert from 'assert';

const toArray = (x) => [].concat(x);

const objectToArgs = (method, obj) =>
    map(obj, (val, key) => ({ method, args: [ key, val ] }))

const valsToArgs = (method, vals) =>
    map(toArray(vals), (val) => ({ method, args: [ val ] }))

const isConditional = (obj) =>
    isPlainObject(obj) && has(obj, 'condition') && has(obj, 'message');

const toConditionalArgs = (method, { condition, message }) =>
    ({ method, args: [ condition, message ] })

const createArgs = (key, val) => {
    if (isConditional(val)) return toConditionalArgs(key, val);
    if (isPlainObject(val)) return objectToArgs(key, val);
    /* default */           return valsToArgs(key, val);
}

const collectArgs = (coll, val, key) =>
    coll.concat(createArgs(key, val));

const getMethodInvocation = (spec) =>
    reduce(spec, collectArgs, []);


const invoke = (fn, { method, args }) => {
    assert(fn[method], 'Yargs does not have method ' + method);
    return fn[method](...args)
}

const yargBuilder = (spec = {}, argv = process.argv.slice(2), yargs = Yargs) =>
    reduce(getMethodInvocation(spec),
           invoke,
           yargs(argv));

export default yargBuilder;
export { getMethodInvocation };
