# coffeelint: disable=max_line_length

$ = jQuery

any = (a) -> a[Math.floor Math.random() * a.length]

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

localQuotes = []
getLocalQuote = ->
  if localQuotes.length is 0
    $.getJSON 'data/quotes.json', (quotes) ->
      localQuotes = quotes
      getLocalQuote()
  else
    quote = any localQuotes
    renderQuote quote
    scheduleGetQuote quote

errorGettingQuote = ->
  getLocalQuote()

getQuote = ->
  $.getJSON 'quotes/any', renderQuote
    .done scheduleGetQuote
    .fail errorGettingQuote

calculateTimeoutInMs = (quote) ->
  numWords = (txt) -> txt.split(/\s+/).length
  totalWords = numWords(quote.text) + numWords(quote.author)
  # typical reading speed is 200wpm (words per minute)
  # use a minimum of 5s, and add a 1s buffer
  Math.max 5000, totalWords / 200.0 * 60 * 1000 + 1000

scheduleGetQuote = (quote) ->
  window.setTimeout getQuote, calculateTimeoutInMs(quote)

setupBackgrounds = ->
  # Backgrounds are chromecast backgrounds from:
  # https://github.com/dconnolly/chromecast-backgrounds
  $.getJSON 'data/backgrounds.json', (backgrounds) ->
    changeBackground = ->
      bg = any(backgrounds)
      $('body').css 'background-image', "url(#{bg.url})"
      $('#footer').text if bg.author then "Photo by #{bg.author}" else ''
    changeBackground()
    window.setInterval changeBackground, 30000

$ ->
  setupBackgrounds()
  scheduleGetQuote text: $('#quote').text(), author: $('#author').text()
