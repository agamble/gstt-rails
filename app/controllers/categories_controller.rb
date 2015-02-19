class CategoriesController < ApplicationController
  before_action :authenticate_patient!
  before_action :set_patient
  before_action :set_state

  def show
    @category = Category.find_by(id: params[:id])
    @subcategories = @state.subcategories_of(@category)
  end

  private

  def set_patient
    @patient = current_patient
  end

  def set_state
    if params[:state]
      # need to add verification patient owns state
      @state = TreatmentState.find_by_id(params[:state])
    else
      @state = TreatmentState.most_recent_for_patient @patient
    end
  end

  # def present_treatment_state
  #   id = nil
  #   @patient.pathway.treatment_states.each do |i|
  #     if (i.categories.include? @category) && i.timeframe == "present"
  #       return i.id
  #     end
  #     if i.categories.include? @category
  #       id = i.id
  #     end
  #   end
  #   return id
  # end
end
