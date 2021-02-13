class LabelsController < ApplicationController

  def show
    @labelling = @task.labellings.find_by(label_id: @label.id)
  end

end
