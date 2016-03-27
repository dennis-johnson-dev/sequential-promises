# Resolving ES2015 Promises sequentially

### Running the tests

```bash
npm install
npm test
```

> Note: examples in coffeescript

### getResultsInSequence(promises, timeout)

Given an array of promises, resolve each promise serially and depending on a given timeout

**promises**: *required* - array of promises <br />
**timeout**: *optional* - milliseconds between resolves

Example:

```js
arrayOfPromises = [Promise.resolve(42), Promise.resolve(39)]

getResultsInSequence(arrayOfPromises).then((results) ->
  return results
)

// results = [42, 39]
```

### Nested Promises

You can use any method you like to create an array of promises. This can be beneficial if you would like to do things such as:

```js
nestedPromises = [Promise.resolve(42), Promise.resolve(39)]
arrayOfPromises = [Promise.all(nestedPromises), Promise.resolve(1)]

getResultsInSequence(arrayOfPromises).then((results) ->
  return results
)

// results = [[42, 39], 1]
```

This means you batch your promises however you like.

### Using a timeout

If you need to resolve each promise after an interval, you can pass a timeout value. The method will wait the timeout before resolving each promise. If you have 10 promises and pass a timeout of 1000, it will take 10 seconds before the function returns.

```js
promises = [Promise.resolve(42), Promise.resolve(39)]
arrayOfPromises = [Promise.all(promises), Promise.resolve(1)]
timeout = 1000

getResultsInSequence(arrayOfPromises, timeout).then((results) ->
  return results
)

// results after 2 seconds = [[42, 39], 1]
```
