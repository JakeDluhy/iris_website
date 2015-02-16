class TestAssignmentsController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update]

  def create
    existing = TestAssignment.where({:user_id => current_user.id, :test_objective_id => params["test_assignment"]["test_objective_id"]})
    @assignment = TestAssignment.new(assignment_params)
    @assignment.user_id = current_user.id
    if existing.empty? and @assignment.save
      redirect_to @assignment.test_objective.test
    else
      redirect_to @assignment.test_objective.test
    end
  end

  private

    def assignment_params
      params.require(:test_assignment).permit(:user_id, :test_objective_id)
    end
end
