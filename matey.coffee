Router.route "home", path: "/"

@Boards = new Meteor.Collection "boards"

if Meteor.isServer
  Meteor.publish "boards", ->
    Boards.find()

  if Boards.find().count() is 0
    Boards.insert Board.initialBoard

if Meteor.isClient
  Meteor.subscribe "boards"
  Tracker.autorun (c)->
    board_count = Boards.find().count()
    unless c.firstRun
      Board.render( _.last(Boards.find().fetch()) )
