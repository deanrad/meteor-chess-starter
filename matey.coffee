Router.route "home", path: "/"

@Boards = new Meteor.Collection "boards"

if Meteor.isServer
  Meteor.publish "boards", ->
    Boards.find()

  if Boards.find().count() is 0
    Boards.insert Board.initialBoard

  Meteor.methods
    reset: ->
      Boards.remove({})
      Boards.insert Board.initialBoard

if Meteor.isClient
  Meteor.subscribe "boards"
  Tracker.autorun (c)->
    board_count = Boards.find().count()
    unless c.firstRun
      @board = _.last(Boards.find().fetch())
      Board.render(@board) if @board

  Template.newGame.events
    "click #reset": ->
      Meteor.call "reset"
