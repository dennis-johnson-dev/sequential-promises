_ = require 'lodash'

iteratePromises = (iteratorFn, timeout) ->
  new Promise((resolve, reject) ->
    it = iteratorFn

    nextFunc = (val) ->
      next = it.next(val)
      done = next.done
      isError = _.isError(next.value)

      if (isError)
        reject(next.value)

      if (!done)
        next.value.then(
          (resolvedValue) ->
            setTimeout(() ->
              nextFunc(resolvedValue)
            , timeout)
          (err) ->
            it.throw(err)
            nextFunc(err)
        )
      else
        resolve(next.value)

    nextFunc()
  )

generatorFn = (promises) ->
  results = []

  for promise in promises
    try
      console.log('resolving...', results)
      results.push yield promise
    catch e
      yield e
      return e

  results

getResultsInSequence = (promises, timeout) ->
  iteratePromises(
    generatorFn(promises),
    timeout
  )

module.exports = { getResultsInSequence };
