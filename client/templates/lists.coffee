Template.lists.lists = ->
  Lists.find {}, {sort: {name: 1}}

Template.list_item.selected = -> 
  if Session.equals('list_id', this._id) then 'selected' else ''

Template.list_item.name_class = -> 
  if this.name then '' else 'empty'

Template.list_item.editing = -> 
  Session.equals 'editing_listname', this._id


# list item event handle
listItemHdl = 
  'mousedown': (evt) -> # select list
    Router.setList this._id

  'dblclick': (evt) -> # start editing list name
    Session.set 'editing_listname', this._id
    Meteor.flush() # force DOM redraw, so we can focus the edit field
    $("#list-name-input").focus()

# mousedown and dblclick event on each list items
Template.list_item.events listItemHdl


# new-list input box dom element event handler
newListHdl =
  ok: (text, evt) ->
    id = Lists.insert {name: text}
    Router.setList id
    evt.target.value = ""
  
# new-list input box text handler, create a new list
evtmap = okCancelEvents "#new-list", newListHdl
Template.lists.events evtmap


# input box existing list input box(focus after dblclick) event handler
listInputHdl =
  ok: (text) ->
    Lists.update this._id, {$set: {name: text}}
    Session.set 'editing_listname', null
  cancel: () ->
    Session.set 'editing_listname', null
  save_on_blur: true

# existing list name input box (focus after dblclick)  
evtmap = okCancelEvents "#list-name-input", listInputHdl
Template.list_item.events evtmap
