generatePromises = (total) ->
  promises = []
  for num in [1..total]
    promises[num] = new Promise (resolve, reject) ->
      value = getRandomValue(100)
      if value > 1 then resolve(value) else reject(new Error "Value not valid: #{value}")

getRandomValue = (range) -> Math.round(Math.random() * range, 0)

module.exports = { generatePromises, getRandomValue };
