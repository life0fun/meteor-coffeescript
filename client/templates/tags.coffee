Template.todo_tag.events =
  'click .remove': (evt) ->
    tag = this.tag
    id  = this.todo_id

    evt.target.parentNode.style.opacity = 0
    # wait for CSS animation to finish
    Meteor.setTimeout(->
      Todos.update {_id: id}, {$pull: {tags: tag}}
    , 300)

# template's computed property. called from template when it trying to render a list item.
# list comprehension to ret a map of {tag: name, count: 10}
Template.tag_filter.tags = ->
  tag_counts  = {}
  total_count = 0

  for todo in Todos.find({list_id: Session.get("list_id")}).fetch()
    for tag in todo.tags
      tag_counts[tag] = 0 unless tag_counts[tag]?
      tag_counts[tag]++
    total_count++

  tag_infos = for tag, count of tag_counts
    { tag: tag, count: count }

  tag_infos = _.sortBy tag_infos, (x) -> x.tag
  tag_infos.unshift { tag: null, count: total_count }

  return tag_infos

# tag_item is item in the top bar tag_filter
Template.tag_item.tag_text = -> 
  console.log "getting tag_text :", this.tag
  this.tag or "All items"

Template.tag_item.selected = -> 
  if Session.equals('tag_filter', this.tag) then 'selected' else ''

# tag_item is an item in top tag_filter list collection.
Template.tag_item.events
  'mousedown': ->
    console.log "tag_item events "
    if Session.equals 'tag_filter', this.tag
      Session.set 'tag_filter', null
    else
      Session.set 'tag_filter', this.tag


# bind todo_item dom event handler
editTagHdl =
  ok: (value) ->
    console.log "editting tag value ", value
    Todos.update this._id, {$addToSet: {tags: value}}
    Session.set "editing_addtag", null
  cancel: ->
    Session.set "editing_addtag", null

evtmap = okCancelEvents "#edittag-input", editTagHdl
console.log "setting up evtmap :", evtmap
Template.todo_item.events evtmap
