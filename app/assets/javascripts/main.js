App = Ember.Application.create();

App.Router.map(function() {
  // put your routes here
  this.resource('recipes', function(){
    this.route('new');
    this.route('edit', {path: "/:recipe_id/edit" });
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
    return this.store.find('recipe', params.recipe_id);
  }
});

App.RecipeRoute = Ember.Route.extend({
  renderTemplate: function(){
    this.render('recipe',
                {
                 into: 'application',
                 controller: 'recipe'
                });
  },
  model: function(params) {
    return this.store.find('recipe', params.recipe_id);
  }
});

App.RecipesController = Ember.ArrayController.extend({
  sortProperties: ['name'],
});

App.RecipeController = Ember.Controller.extend({
  ratings: [5,4,3,2,1],
  actions: {
    removeRecipe: function(){
      var recipe = this.get('model');
      var controller = this;
      recipe.deleteRecord();
      recipe.save().then(function(){
        controller.transitionToRoute('index');
      });
    },
    createRecipe: function() {
      var controller = this;
      this.get('model').save().then(function() {
        controller.transitionToRoute('index');
      });
    }
  }
});
App.RecipesNewController = App.RecipeController.extend({
});
App.RecipesEditController = App.RecipeController.extend({
});


App.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: 'api'
});

App.Recipe = DS.Model.extend({
  name: DS.attr(),
  description: DS.attr(),
  rating: DS.attr('number')
});
