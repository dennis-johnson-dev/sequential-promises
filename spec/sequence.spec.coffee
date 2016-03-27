{ generatePromises } = require './support/promiseGenerator'
{ getResultsInSequence } = require '../src/sequence'

describe '#getResultsInSequence', () ->
  timeout = 0
  err = 'oops'

  resolvesToThirty = Promise.resolve(30)
  rejectsToErr = Promise.reject(new Error(err))
  resolvesToArrayOfThirty = Promise.all([resolvesToThirty, resolvesToThirty])

  it 'resolves a promise', () ->
    promises = [resolvesToThirty]
    expect(getResultsInSequence(promises, timeout)).to.eventually.become([30])

  it 'resolves an array of promises', () ->
    promises = [resolvesToArrayOfThirty]
    expect(getResultsInSequence(promises, timeout)).to.eventually.become([[30, 30]])

  it 'resolves an array of promises with mixed types', () ->
    promises = [resolvesToArrayOfThirty, resolvesToThirty]
    expect(getResultsInSequence(promises, timeout)).to.eventually.become([[30, 30], 30])

  it 'rejects on error', () ->
    promises = [resolvesToThirty, rejectsToErr]
    expect(getResultsInSequence(promises, timeout)).to.be.rejectedWith(err)

describe 'Demo', () ->
  promises = generatePromises(5)
  timeout = 0

  printVals = (vals) -> console.log('resolved', vals)
  rejectFn = (errs) -> console.log('rejected,', errs)

  getResultsInParallel = (promises, timeout) ->
    getResultsInSequence([Promise.all(promises)], timeout)

  it 'consecutive and nested promises', () ->
    expect(getResultsInSequence(promises, timeout)
      .then(printVals)
      .then(() -> getResultsInParallel(promises, timeout))
      .then(printVals, rejectFn)
      .then(() -> console.log('resolved an array!'))).to.be.fulfilled
