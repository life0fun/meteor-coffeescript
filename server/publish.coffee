# Lists -- {name: String}
#Lists = new Meteor.Collection "lists"

# publish fn called on the server each time a clinet subscribes.
# Inside pub fn, this refers to handler client holds after subscribe.
# Inside publish fn, use this.stop() to Stop this client's subscription
# If the client passes args to subscribe fn, the publish fn is called with the same arg.
# to avoid push down the entire records to client, publish fn should call
# the fn added, changed, removed, to inform subscribers about the doc.
# List.find().observeChanges({added : function(id){}, changed: function(id){}})


# Publish complete set of todo lists to "lists" set to all clients 
# who subscribed to the 
Meteor.publish 'lists', ->
  console.log "publishing all lists by Lists.find()..."
  Lists.find()


# Todos -- {text: String,
#           done: Boolean,
#           tags: [String, ...],
#           list_id: String,
#           timestamp: Number}
#Todos = new Meteor.Collection "todos"

# Publish all items for requested list_id to client.
# one way to avoidMessages.find({roomId: roomId}).observeChanges({
Meteor.publish 'todos', (list_id) -> 
  console.log "publishing todo within list ", list_id
  Todos.find {list_id: list_id}


