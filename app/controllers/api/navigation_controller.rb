class Api::NavigationController < Api::ApiController
  def index
    nav = [
      {
        link_to: 'updates',
        symbol: 'comment',
        tooltip: 'Updates'
      },
      # {
      #   link_to: 'tutorials',
      #   symbol: 'university',
      #   tooltip: 'Tutorials'
      # },
      {
        link_to: 'resources',
        symbol: 'university',
        tooltip: 'Resources'
      },
      {
        link_to: 'tasks',
        symbol: 'pencil',
        tooltip: 'Tasks'
      },
      # {
      #   link_to: 'users',
      #   symbol: 'group',
      #   tooltip: 'Users'
      # },
      {
        link_to: 'calendar',
        symbol: 'calendar',
        tooltip: 'Calendar'
      }
    ];
    render :json => nav.to_json
  end
end