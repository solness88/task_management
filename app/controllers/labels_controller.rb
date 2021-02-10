class LabelsController < ApplicationController

  def show
    @task_label = @task.task_labels.find_by(label_id: @label.id)
  end

end
