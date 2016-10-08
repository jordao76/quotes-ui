$ = jQuery

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

error = ->
  console.error 'Error getting quote', arguments

getQuote = ->
  $.getJSON 'quotes/any', renderQuote
    .done scheduleGetQuote
    .fail error

scheduleGetQuote = (quote) ->
  timeoutInMs = 10000
  window.setTimeout getQuote, timeoutInMs

$ scheduleGetQuote
