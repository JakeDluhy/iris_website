$(document).ready(function() {
  FrontPage = new Backbone.Marionette.Application();

  /* -------------- Models -----------------------
  --------------------------------------------- */

  Task = Backbone.Model.extend({
    url: function() {'/api/tasks/' + this.get('id') + '.json'}
  });

  Update = Backbone.Model.extend({
    url: function() {'/api/updates/' + this.get('id') + '.json'}
  });

  User = Backbone.Model.extend({
    url: function() {'/api/users/' + this.get('id') + '.json'}
  });

  Tutorial = Backbone.Model.extend({
    url: function() {'/api/users/' + this.get('id') + '.json'}
  });

  Nav = Backbone.Model.extend({

  });


  /* -------------- Collectionss -----------------------
  --------------------------------------------------- */

  TasksCollection = Backbone.Collection.extend({
    model: Task,
    url: '/api/tasks.json'
  });

  UpdatesCollection = Backbone.Collection.extend({
    model: Update,
    url: '/api/updates.json'
  });

  UsersCollection = Backbone.Collection.extend({
    model: User,
    url: '/api/users.json'
  });

  TutorialsCollection = Backbone.Collection.extend({
    model: Tutorial,
    url: '/api/tutorials.json'
  });

  NavigationCollection = Backbone.Collection.extend({
    model: Nav,
    url: '/api/navigation.json'
  })

  /* -------------- Views ------------------------
  --------------------------------------------- */

  TaskView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/task'],
    tagName: 'div',
    className: 'display-item-card',
  });

  UpdateView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/update'],
    tagName: 'div',
    className: 'display-item-card'
  });

  UserView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/user'],
    tagName: 'div',
    className: 'display-item-card',
    onShow: function() {
      
    }
  });

  CalendarView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/calendar'],
    tagName: 'div',
    className: 'calendar-container'
  });

  TutorialView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/tutorial'],
    tagName: 'div',
    className: 'display-item-card tutorial-card',

    events: {
      'click .instruction-toggle' : 'toggleInstructions',
      'click .instruction-expand' : 'expandInstructions',
      'click .instruction-collapse': 'collapseInstructions',
      'click .instruction-container' : 'toggleInstruction'
    },

    /* ------------ Event Handlers -------------------- */

    toggleInstructions: function(event) {
      if(this.$el.find('.instructions-container').hasClass('hidden')){
        this.$el.find('.instructions-container').removeClass('hidden');
        $(event.target).html('Hide');
      } else {
        this.$el.find('.instructions-container').addClass('hidden');
        $(event.target).html('Show');
      }
    },
    expandInstructions: function(event) {
      this.$el.find('.instructions-container').removeClass('hidden');
      this.$el.find('.instruction-toggle').html('Hide');
      this.$el.find('.instruction-content').removeClass('hidden');
    },
    collapseInstructions: function() {
      this.$el.find('.instruction-content').addClass('hidden');
    },
    toggleInstruction: function(event) {
      if(!$(event.target).hasClass('content-pic')) {
        $(event.target).closest('.instruction-container').find('.instruction-content').toggleClass('hidden');
      }
    }
  });



  NavView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/nav'],
    tagName: 'button',
    className: 'navigation-link tooltip-bottom',
    attributes: function() {
      var tooltip = this.model.get('tooltip');
      return {
        'data-tooltip': tooltip
      }
    },

    onShow: function() {
      this.setIndicators();
    },
    
    events: {
      'mouseover': 'showArrows',
      'mouseout': 'removeArrow',
      'mouseover .nav-arrow': 'showArrows',
      'mouseout .nav-arrow': 'removeArrows',
      'click .left-arrow': 'setLeft',
      'click .right-arrow': 'setRight'
    },

    /* ------------ Event Handlers -------------------- */

    showArrows: function() {
      this.$el.find('.nav-arrow').removeClass('blanked-out');
    },
    removeArrow: function() {
      this.setIndicators();
    },
    setLeft: function() {
      this.determineDisplays('left');
    },
    setRight: function() {
      this.determineDisplays('right');
    },



    determineDisplays: function(side) {
      var currentLeft = docCookies.getItem('leftType');
      var currentRight = docCookies.getItem('rightType');
      var leftType = currentLeft;
      var rightType = currentRight;
      if(side === 'right') {
        rightType = this.model.get('link_to');
        ((currentLeft === this.model.get('link_to')) ? leftType = currentRight : leftType = currentLeft);
      } else if (side === 'left') {
        leftType = this.model.get('link_to');
        ((currentRight === this.model.get('link_to')) ? rightType = currentLeft : rightType = currentRight);
      } else { console.log('error'); }
      FrontPage.commands.execute('displayItems', leftType, rightType);
      this.model.collection.fetch(); //Hack, should think of better way to rerender items
    },


    setIndicators: function() {
      if(docCookies.getItem('leftType') === this.model.get('link_to')) {
        this.$el.find('.left-arrow').removeClass('blanked-out');
        this.$el.find('.right-arrow').addClass('blanked-out');
        this.$el.find('.left-arrow').addClass('orange-it');
      } else if(docCookies.getItem('rightType') === this.model.get('link_to')) {
        this.$el.find('.right-arrow').removeClass('blanked-out');
        this.$el.find('.left-arrow').addClass('blanked-out');
        this.$el.find('.right-arrow').addClass('orange-it');
      } else {
        this.$el.find('.nav-arrow').addClass('blanked-out');
        this.$el.find('.nav-arrow').removeClass('orange-it');
      }
    }
  });

  TasksView = Backbone.Marionette.CollectionView.extend({
    childView: TaskView
  });

  UpdatesView = Backbone.Marionette.CollectionView.extend({
    childView: UpdateView
  });

  UsersView = Backbone.Marionette.CollectionView.extend({
    childView: UserView
  });

  TutorialsView = Backbone.Marionette.CollectionView.extend({
    childView: TutorialView
  });

  NavigationView = Backbone.Marionette.CollectionView.extend({
    childView: NavView
  });

  /* -------------- Regions ------------------------
  ----------------------------------------------- */

  DisplayRegion = Marionette.Region.extend({
    showUpdates: function() {
      var updatesCollection = new UpdatesCollection();
      var self = this;
      updatesCollection.fetch({
        success: function() {
          var updatesView = new UpdatesView({collection: updatesCollection});
          self.show(updatesView);
        }
      });
    },
    showTutorials: function() {
      var tutorialsCollection = new TutorialsCollection();
      var self = this;
      tutorialsCollection.fetch({
        success: function() {
          var tutorialsView = new TutorialsView({collection: tutorialsCollection});
          self.show(tutorialsView);
        }
      });
    },
    showTasks: function() {
      var tasksCollection = new TasksCollection();
      var self = this;
      tasksCollection.fetch({
        success: function() {
          var tasksView = new TasksView({collection: tasksCollection});
          self.show(tasksView);
        }
      });
    },
    showUsers: function() {
      var usersCollection = new UsersCollection();
      var self = this;
      usersCollection.fetch({
        success: function() {
          var usersView = new UsersView({collection: usersCollection});
          self.show(usersView);
        }
      });
    },
    showCalendar: function() {
      var calendarView = new CalendarView();
      this.show(calendarView);
    }
  });

  (FrontPage.loadRegions = function() {
    FrontPage.addRegions({
      leftRegion: {
        selector: '#left-half-div',
        regionClass: DisplayRegion
      },
      navRegion: '#navigation-div',
      rightRegion: {
        selector: '#right-half-div',
        regionClass: DisplayRegion
      }
    });
  })();

  /* -------------- Router and Controller ------------------------
  ------------------------------------------------------------- */

  Router = Marionette.AppRouter.extend({
    appRoutes: {
        ''  : 'home'
    }
  });

  Controller = Marionette.Controller.extend({
    home: function() {
      console.log('home');
    }
  });

  /* -------------- Startup ------------------------
  ----------------------------------------------- */

  FrontPage.displayItems = function(leftType, rightType) {
    if(leftType === null) {
      if(rightType === 'updates') {
        docCookies.setItem('leftType', 'calendar', Infinity);
        FrontPage.leftRegion.showCalendar();
      } else {
        docCookies.setItem('leftType', 'updates', Infinity);
        FrontPage.leftRegion.showUpdates();
      }
    } else {
      switch(leftType){
        case 'updates':
          FrontPage.leftRegion.showUpdates();
          break;
        case 'tutorials':
          FrontPage.leftRegion.showTutorials();
          break;
        case 'tasks':
          FrontPage.leftRegion.showTasks();
          break;
        case 'calendar':
          FrontPage.leftRegion.showCalendar();
          break;
        default:
          FrontPage.leftRegion.showUpdates();
          break;
      }
    }
    if(rightType === null) {
      if(leftType === 'calendar') {
        docCookies.setItem('rightType', 'updates', Infinity);
        FrontPage.rightRegion.showUpdates();
      } else {
        docCookies.setItem('rightType', 'calendar', Infinity);
        FrontPage.rightRegion.showCalendar();
      }
    } else {
      switch(rightType){
        case 'updates':
          FrontPage.rightRegion.showUpdates();
          break;
        case 'tutorials':
          FrontPage.rightRegion.showTutorials();
          break;
        case 'tasks':
          FrontPage.rightRegion.showTasks();
          break;
        case 'calendar':
          FrontPage.rightRegion.showCalendar();
          break;
        default:
          FrontPage.rightRegion.showCalendar();
          break;
      }
    }
  };

  FrontPage.addInitializer(function(options) {
    var leftType = docCookies.getItem('leftType');
    var rightType = docCookies.getItem('rightType');
    // var leftFilter = docCookies.getItem('leftFilter');
    // var rightFilter = docCookies.getItem('rightFilter');
    FrontPage.displayItems(leftType, rightType);
    var navCollection = new NavigationCollection();

    navCollection.fetch({
      success: function() {
        var navView = new NavigationView({collection: navCollection});
        FrontPage.navRegion.show(navView);
      }
    });

    FrontPage.commands.setHandler('displayItems', function(leftType, rightType) {
      docCookies.setItem('leftType', leftType, Infinity);
      docCookies.setItem('rightType', rightType, Infinity);
      // docCookies.setItem('leftFilter', leftFilter, Infinity);
      // docCookies.setItem('rightFilter', rightFilter, Infinity);
      FrontPage.displayItems(leftType, rightType);
    });
    var controller = new Controller();
    var router = new Router({controller: controller});
  });




  FrontPage.start();
});

