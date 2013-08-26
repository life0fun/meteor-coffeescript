# ID of currently selected list
Session.set 'list_id', null

# Name of currently selected tag for filtering
Session.set 'tag_filter', null

# When adding tag to a todo, ID of the todo
Session.set 'editing_addtag', null

# When editing a list name, ID of the list
Session.set 'editing_listname', null

# module scope variable declare once
subListHdl = subListHdl ? null

# Subscribe to 'lists' collection on startup.
# this should called only once.
@subscribeToList = ->
  console.log "subscribe to list handle ", subListHdl
  if not subListHdl?
    subListHdl = Meteor.subscribe 'lists', ->
      if !Session.get('list_id')
        list = Lists.findOne {}, {sort: {name: 1}}
        Router.setList(list._id) if list
    console.log "after sub list handle ", subListHdl


# Always be subscribed to the todos for the selected list.
# autosubscribe is deprecated, use autoRun.
# When you want to automatically update the subscription whenever the session variable changes.
@subscriptionHdl
autoRun = ->
  Deps.autorun ->
    list_id = Session.get 'list_id'
    console.log 'session vars changed, auto subscribe lists ', list_id
    subscriptionHdl = Meteor.subscribe 'todos', list_id if list_id

