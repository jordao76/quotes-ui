# coffeelint: disable=max_line_length

$ = jQuery

sampleQuotes = [
  {
    text: 'On two occasions I have been asked, "Pray, Mr. Babbage, if you put into
      the machine wrong figures, will the right answers come out?" I am not able
      rightly to apprehend the kind of confusion of ideas that could provoke such
      a question.'
    author: 'Charles Babbage'
  }
  {
    text: 'Any sufficiently advanced technology is indistinguishable from magic.'
    author: 'Arthur C. Clarke'
  }
  {
    text: 'Perfection (in design) is achieved not when there is nothing more to
      add, but rather when there is nothing more to take away.'
    author: 'Antoine de Saint-Exupery'
  }
]

adjustSize = (quote) ->
  quoteLength = quote.text.length
  size =
    if quoteLength < 50
      '4em'
    else if quoteLength < 100
      '3em'
    else
      '2em'
  $('#quote').css 'font-size', size

renderQuote = (quote) ->
  adjustSize quote
  $('#quote').text quote.text
  $('#author').text quote.author

getSampleQuote = ->
  random = (n) -> Math.floor Math.random() * n
  quote = sampleQuotes[random sampleQuotes.length]
  renderQuote quote
  scheduleGetQuote quote

errorGettingQuote = ->
  getSampleQuote()

getQuote = ->
  $.getJSON 'quotes/any', renderQuote
    .done scheduleGetQuote
    .fail errorGettingQuote

calculateTimeoutInMs = (quote) ->
  numWords = (txt) -> txt.split(/\s+/).length
  totalWords = numWords(quote.text) + numWords(quote.author)
  # typical reading speed is 200wpm (words per minute)
  # use a minimum of 5s
  Math.max 5000, (totalWords / 200.0) * 60 * 1000

scheduleGetQuote = (quote) ->
  window.setTimeout getQuote, calculateTimeoutInMs(quote)

$ ->
  scheduleGetQuote text: $('#quote').text(), author: $('#author').text()
