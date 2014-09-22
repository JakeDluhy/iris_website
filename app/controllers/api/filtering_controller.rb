class Api::FilteringController < Api::ApiController
  def index
    filtering = [
      {
        link_to: 'all',
        label: 'ALL',
        tooltip: 'All'
      },
      {
        link_to: 'teams',
        symbol: 'TEAM',
        tooltip: 'Teams'
      },
      {
        link_to: 'subteams',
        symbol: 'SUB',
        tooltip: 'Subteams'
      },
      {
        link_to: 'general',
        symbol: 'GEN',
        tooltip: 'General'
      }
    ];
    render :json => filtering.to_json
  end
end