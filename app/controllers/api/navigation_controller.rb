class Api::NavigationController < Api::ApiController
  def index
    nav = [
      {
        link_to: 'updates',
        symbol: 'comment'
      },
      {
        link_to: 'tutorials',
        symbol: 'university'
      },
      {
        link_to: 'tasks',
        symbol: 'pencil'
      },
      {
        link_to: 'users',
        symbol: 'group'
      }
    ];
    render :json => nav.to_json
  end
end