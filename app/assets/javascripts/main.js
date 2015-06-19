App = Ember.Application.create();

App.Router.map(function() {
  // put your routes here
  this.resource('recipes', function(){
    this.route('new');
    this.route('edit', {path: "/edit/:recipe_id" });
  });
  this.resource('recipe', {path: '/recipe/:recipe_id'}, function(){
  });
});

App.IndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('recipe')
  }
});

App.RecipesNewRoute = Ember.Route.extend({
  renderTemplate: function(){
    this.render('recipes/new', { into: 'application' });
  },
  model: function() {
    return this.store.createRecord('recipe');
  }
});

App.RecipesEditRoute = Ember.Route.extend({
  renderTemplate: function(){
    this.render('recipes/new', 
                {
                 into: 'application',
                 controller: 'recipesEdit'
                });
  },
  model: function(params) {
    return this.store.find('recipe', 1);
  }
});

App.RecipesController = Ember.ArrayController.extend({
  sortProperties: ['name']
});

App.RecipesNewController = Ember.Controller.extend({
  ratings: [5,4,3,2,1],
  actions: {
    createRecipe: function() {
      var controller = this;
      this.get('model').save().then(function() {
        controller.transitionToRoute('index');
      });
    }
  }
});

App.RecipesEditController = Ember.Controller.extend({
  ratings: [5,4,3,2,1],
  actions: {
    createRecipe: function() {
      var controller = this;
      this.get('model').save().then(function() {
        controller.transitionToRoute('index');
      });
    }
  }
});
App.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: 'api'
});

App.Recipe = DS.Model.extend({
  name: DS.attr(),
  description: DS.attr(),
  rating: DS.attr('number')
});
