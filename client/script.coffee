# coffee --compile --inline-map script.coffee 

fetch('http://localhost:4567/anime').then (response) ->
  response.text().then (text) ->
    list = text.split(',')
    json = []
    list.forEach (item) ->
      newItem = item.replace('=>', ':')
      if newItem != ""
          json.push newItem
    title = json[0].split('') 
    word = []
    title.forEach (letter, index) ->
        if index >= 13 and index <= json[0].split('').length - 3
            word.push letter
    # note: really not happy with the naming of these variables 
    finalTitle = word.join().replace(/,/g, '')
    document.querySelector("#anime-list").innerHTML += "<div class='anime'>title: " + finalTitle + "</div>" 
  return

# experienced issue/s related to Cors 
document.addEventListener 'click', ->
    title = document.querySelector("#anime-input").value 
    console.log title
    fetch('http://localhost:4567/anime',
    method: 'POST'
    mode: 'cors'
    headers:
        'Access-Control-Allow-Origin': '*'
        'Accept': 'application/text'
        'Content-Type': 'application/text'
    body: 'anime: akame').then (data) ->
    console.log data
    return

