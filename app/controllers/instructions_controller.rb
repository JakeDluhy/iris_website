class InstructionsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  def new
    @intruction = Instruction.new
  end

  def show
    @instruction = Instruction.find(params[:id])
  end

  def create
    @instruction = Instruction.new(instructions_params)
    if @instruction.save
      render :json => @instruction.to_json
    end
  end

  def destroy
    instruction = Instruction.find(params[:id]).destroy
    redirect_to instruction.tutorial
  end

  private

    def instructions_params
      params.require(:instruction).permit(:title, :content, :pictures, :tutorial_id, :order_id)
    end
end
