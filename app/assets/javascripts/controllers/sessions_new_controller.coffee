App.SessionsNewController = Ember.ObjectController.extend
  needs: ["currentUser"]
  save: ->
    @content.save().then =>
      userJSON = @content.toJSON()
      userJSON.id = "current"
      object = @store.load(App.User, userJSON)
      user = App.User.find("current")
      @get("controllers.currentUser").set "content", user
      @transitionToRoute "index"

