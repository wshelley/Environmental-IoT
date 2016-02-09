module.exports = class
  constructor: ()->
    @total = 0
    @ranges = []

  ###
  Adds a period of time which this clock will loop over
  ###
  add: (start, end)->
    diff = end.getTime() - start.getTime()
    @ranges.push start: start.getTime(), length: diff
    @total += diff

  ###
  Return a time which exists in one of the periods set with:
    .add(start, end)
  Which is derived from the current real time
  ###
  getTime: -> 
    offset = @getRealTime() % @total
    for range in @ranges
      withinRange = offset < range.length
      return new Date(range.start + offset) if withinRange
      offset -= range.length

  ###
  Return the current time in milliseconds since 1970. In a production 
  environment, this function should return a value with increments over time.
  ###
  getRealTime: -> new Date().getTime()