class InventorsController < ApplicationController
  def edit
    @inventor = Inventor.find(params[:id])
  end
  
  def update
    @inventor = Inventor.find(params[:id])
    if @inventor.update_attributes(params[:inventor])
      flash[:notice] = I18n.t(:success_update)
      redirect_to questionnaire_step2_path
    else
      render :action => "edit"
    end 
  end
  
  def destroy
    @inventor = Inventor.find(params[:id])
    @inventor.destroy
    redirect_to questionnaire_step2_path
  end
end
