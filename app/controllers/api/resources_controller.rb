class Api::ResourcesController < Api::ApiController
  def index
    @resources = [
      {
        name: 'Part Request Form',
        url: 'https://docs.google.com/a/illinois.edu/forms/d/1ojzTCi2I5Xh_f1pLjHt21jc8IuGGnj8d0hAZ4vxTHTw/viewform?usp=send_form#start=embed',
        description: 'Use this form to log a part request. This is incredibly important, so that we know everything that needs to be ordered!'
      },
      {
        name: 'Tasks Signup Form',
        url: 'https://docs.google.com/spreadsheets/d/19309h95gzmfrhw-VmhwA5OmTqwnur6_yf6LHGu2z2Ko/edit#gid=2093692234',
        description: 'Use this form to signup for tasks. This will ensure that everyone knows what everyone else is working on. It is very important!'
      }
    ]
    render :json => @resources.to_json
  end
end
