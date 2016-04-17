App.cable.subscriptions.create 'MessagesChannel',
  received: (data) ->
    node = document.createElement('li')
    node.innerText = 'Client ID: ' + data.client_id + ' Content: ' + data.content
    document.getElementById('messages-container').appendChild node
