/*(function($) {
  Teams = $UI.app.module("Teams", {
    startWithParent: true,
    define: function(Teams, App, Backbone, Marionette, $, _) {
      
    }
  });

  Teams.on('start', function(options){
    Backbone.history.stop();
    Backbone.history.start({pushState: true, root: '/'});
  });

  Teams.addInitializer( function(options) {
    this.router = new Teams.Router({ controller: new Teams.Controller() });
  });

  $.extend(Teams, { Models: {}, Collections: {}, Views: {}, Routers: {} });

  $.extend(Reader, {
    teams_path: function() { return '/teams.json'; },
    team_path: function(id) { return '/teams/' + id + '.json'; },
    subteams_path: function() { return '/subteams.json'; },
    subteam_path: function(id) { return '/subteams/' + id + '.json'; }
  });

  Teams.Controller = Backbone.Marionette.Controller.extend({
    initialize: function() {
      this.teams = new Teams.Collections.TeamList();
      this.teams.fetch();
      this.teamsRegion = new Marionette.Region({ el: '.teams-container' });
      this.teamsRegion.show( new Teams.Views.TeamList({ collection: this.teams }) );
    }
  })

})(jQuery);*/