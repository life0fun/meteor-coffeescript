Template.todos.any_list_selected = -> !Session.equals('list_id', null)

Template.todos.todos = ->
  # Determine which todos to display in main pane,
  # selected based on list_id and tag_filter.

  list_id = Session.get 'list_id'
  return {} unless list_id?

  sel = {list_id: list_id}
  tag_filter = Session.get 'tag_filter'
  sel.tags = tag_filter if tag_filter
    
  Todos.find sel, {sort: {timestamp: 1}}

# computed property in todos template to get a map of all tags of the todo
Template.todo_item.tag_objs = ->
  todo_id = this._id
  return _.map(this.tags or [], (tag) -> {todo_id: todo_id, tag: tag})

Template.todo_item.done_class = -> 
  if this.done then 'done' else ''

Template.todo_item.done_checkbox = -> 
  if this.done then 'checked="checked"' else ''

Template.todo_item.editing = -> 
  Session.equals 'editing_itemname', this._id

Template.todo_item.adding_tag = -> 
  Session.equals 'editing_addtag', this._id


# invoke template events fn with event map to set up event handler. can call many times.
todoItemHdl = 
  'click .check': -> Todos.update this._id, {$set: {done: !this.done}}
  'click .destroy': -> Todos.remove this._id
  'click .addtag': (evt) ->
    Session.set 'editing_addtag', this._id
    Meteor.flush() # update DOM before focus
    $("#edittag-input").focus()
  'dblclick .display .todo-text': (evt) ->
    Session.set 'editing_itemname', this._id
    Meteor.flush() # update DOM before focus
    $("#todo-input").focus()

# todo item in todo list
Template.todo_item.events todoItemHdl
  
# event handle got two args, event, and template, possibly additional context data in this.
newTodoHdl = 
  ok: (text, evt) ->
    console.log "newTodoHdl :", text
    tag = Session.get "tag_filter"
    # insert into collection
    Todos.insert
      text:text
      list_id:Session.get("list_id")
      done: false
      timestamp: (new Date()).getTime()
      tags: if tag then [tag] else []
    # clear input text box
    evt.target.value = ""

# new-todo input DOM element event handler, inside todos template.
evtmap = okCancelEvents "#new-todo", newTodoHdl
Template.todos.events evtmap


todoInputHdl = 
  ok: (value) ->
    console.log "todoInputHdl :", value
    Todos.update this._id, {$set: {text: value}}
    Session.set "editing_itemname", null
  cancel: ->
    Session.set "editing_itemname", null
  save_on_blur: true

# todo-input input box is shown only when todo_item template is in editting mode.
# each todo_item line, either show editing input box, or display todo text label.
evtmap = okCancelEvents "#todo-input", todoInputHdl
Template.todo_item.events evtmap

