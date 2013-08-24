# if the database is empty on server start, create some sample data.
Meteor.startup ->
  console.log "Meteor start up list size: ", Lists.find().count()
  if Lists.find().count() is 0
    data = [
      {name: "Meteor Principles",
      contents: [
         ["Data on the Wire", "Simplicity", "Better UX", "Fun"],
         ["One Language", "Simplicity", "Fun"],
         ["Database Everywhere", "Simplicity"],
         ["Latency Compensation", "Better UX"],
         ["Full Stack Reactivity", "Better UX", "Fun"],
         ["Embrace the Ecosystem", "Fun"],
         ["Simplicity Equals Productivity", "Simplicity", "Fun"]
      ]}
      ,
      {name: "Languages",
      contents: [
         ["Lisp", "GC"],
         ["C", "Linked"],
         ["C++", "Objects", "Linked"],
         ["Python", "GC", "Objects"],
         ["Ruby", "GC", "Objects"],
         ["JavaScript", "GC", "Objects"],
         ["Scala", "GC", "Objects"],
         ["Erlang", "GC"],
         ["6502 Assembly", "Linked"]
      ]}
      ,
      {name: "Favorite Scientists",
      contents: [
         ["Ada Lovelace", "Computer Science"],
         ["Grace Hopper", "Computer Science"],
         ["Marie Curie", "Physics", "Chemistry"],
         ["Carl Friedrich Gauss", "Math", "Physics"],
         ["Nikola Tesla", "Physics"],
         ["Claude Shannon", "Math", "Computer Science"]
      ]}
    ]

    timestamp = (new Date()).getTime()
    for datum in data
      list_id = Lists.insert {name: datum.name}
      console.log 'inserting lists : ', datum.name, list_id
      for contents in datum.contents
        console.log 'inserting todos :', contents
        Todos.insert list_id: list_id, text: contents[0], timestamp: timestamp, tags: contents[1..]
        timestamp += 1
