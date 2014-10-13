$(document).ready(function() {
if(window.location.href === "http://localhost:3000/" || window.location.href === "https://irisengineering.herokuapp.com/"){
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
  });


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
    tagName: 'div',
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
      'click .left-arrow': 'setLeft',
      'click .right-arrow': 'setRight'
    },

    /* ------------ Event Handlers -------------------- */

    showArrows: function() {
      if(!this.$el.find('.left-arrow.orange').hasClass('hidden')) {
        this.$el.find('.nav-arrow.right-arrow').removeClass('hidden');
      } else if (!this.$el.find('.right-arrow.orange').hasClass('hidden')) {
        this.$el.find('.nav-arrow.left-arrow').removeClass('hidden');
      } else {
        this.$el.find('.nav-arrow').removeClass('hidden');
      }
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
      console.log(leftType);
      console.log(rightType);
      FrontPage.displayItems(leftType, rightType);
      this.model.collection.fetch(); //Hack, should think of better way to rerender items
    },


    setIndicators: function() {
      if(docCookies.getItem('leftType') === this.model.get('link_to')) {
        this.$el.find('.left-arrow.orange').removeClass('hidden');
        this.$el.find('.right-arrow').addClass('hidden');
      } else if(docCookies.getItem('rightType') === this.model.get('link_to')) {
        this.$el.find('.right-arrow.orange').removeClass('hidden');
        this.$el.find('.left-arrow').addClass('hidden');
      } else {
        this.$el.find('.nav-arrow').addClass('hidden');
      }
    }
  });

  FilterView = Backbone.Marionette.ItemView.extend({
    template: JST['templates/filtering'],
    tagName: 'div',

    events: {
      'click .filter-link-header' : 'expandRetract',
      'click .filter-link'        : 'selectFilter',
    },

    onShow: function() {
      this.setupFilters();
    },

    selectFilter: function(event) {
      var target = $(event.target).parent();
      var filter = target.data('filter');
      docCookies.setItem('filter', filter);
      this.expandRetract();
      this.setupFilters();
      FrontPage.displayItems();
    },

    expandRetract: function() {
      var self = this;
      this.$el.find('.filters-container').animate({
        height: "toggle"
      }, 500, function() {
        self.$el.find('.filters-container').css('overflow', 'visible');
      });

    },

    setupFilters: function() {
      var filter = docCookies.getItem('filter');
      if (filter === null) {
        filter = 'all';
      }
      this.$el.find('.active-info').html(filter.toUpperCase());
      elements = this.$el.find('.filter-link');
      elements.removeClass('active');
      for(var i = 0; i < elements.length; i++){
        if(filter === elements.eq(i).data('filter')) {
          console.log('here');
          elements.eq(i).addClass('active');
        }
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
      var filter = docCookies.getItem('filter');
      var updatesCollection = new UpdatesCollection();
      var self = this;
      updatesCollection.fetch({
        data: {filter: filter},
        success: function() {
          var updatesView = new UpdatesView({collection: updatesCollection});
          self.show(updatesView);
        }
      });
    },
    showTutorials: function() {
      var filter = docCookies.getItem('filter');
      var tutorialsCollection = new TutorialsCollection();
      var self = this;
      tutorialsCollection.fetch({
        data: {filter: filter },
        success: function() {
          var tutorialsView = new TutorialsView({collection: tutorialsCollection});
          self.show(tutorialsView);
        }
      });
    },
    showTasks: function() {
      var filter = docCookies.getItem('filter');
      var tasksCollection = new TasksCollection();
      var self = this;
      tasksCollection.fetch({
        data: {filter: filter },
        success: function() {
          var tasksView = new TasksView({collection: tasksCollection});
          self.show(tasksView);
        }
      });
    },
    showUsers: function() {
      var filter = docCookies.getItem('filter');
      var usersCollection = new UsersCollection();
      var self = this;
      usersCollection.fetch({
        data: {filter: filter },
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
      navRegion: '#nav-region',
      filterRegion: '#filter-region',
      rightRegion: {
        selector: '#right-half-div',
        regionClass: DisplayRegion
      }
    });
  })();

  /* -------------- Startup ------------------------
  ----------------------------------------------- */

  FrontPage.displayItems = function(leftType, rightType) {
    docCookies.setItem('leftType', leftType, Infinity);
    docCookies.setItem('rightType', rightType, Infinity);
    if(leftType === null) {
      if(rightType === 'updates') {
        docCookies.setItem('leftType', 'calendar', Infinity);
        FrontPage.leftRegion.showCalendar();
      } else {
        docCookies.setItem('leftType', 'updates', Infinity);
        FrontPage.leftRegion.showUpdates();
      }
    } else if(leftType === 'users') {
      docCookies.setItem('leftType', 'calendar', Infinity);
      FrontPage.leftRegion.showCalendar();
    }  else {
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
      }  else {
        docCookies.setItem('rightType', 'calendar', Infinity);
        FrontPage.rightRegion.showCalendar();
      }
    } else if(rightType === 'users') {
      docCookies.setItem('rightType', 'calendar', Infinity);
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
    var filter = docCookies.getItem('filter');
    if(filter === null){
      filter = 'all';
      docCookies.setItem('filter', filter, Infinity);
    }
    FrontPage.displayItems(leftType, rightType);
    var navCollection = new NavigationCollection();

    navCollection.fetch({
      success: function() {
        var navView = new NavigationView({collection: navCollection});
        FrontPage.navRegion.show(navView);
      }
    });

    var filterView = new FilterView();
    FrontPage.filterRegion.show(filterView);
  });




  FrontPage.start();
}
});

