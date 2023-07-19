class ApplicantsPetsController < ApplicationController
  def create
    @applicant = Applicant.find(params[:applicant_id])
    @pet = Pet.find(params[:pet_id])

    # Check if the pet is already associated with the applicant
    if @applicant.pets.exists?(@pet.id)
      redirect_to applicant_path(@applicant)
      flash[:error] = 'Pet is already associated with the applicant.'
    else
      @applicant.pets << @pet
    end

    redirect_to @applicant
  end

  def update_adoption_description
    @applicants_pet = ApplicantsPet.find(params[:id])
    if @applicants_pet.update(applicants_pet_params)
      # Update the status to "Pending" for the associated applicant
      @applicant = @applicants_pet.applicant
      @applicant.update(status: 'Pending')
      @applicant.patch(description: 'test')

      redirect_to @applicant, notice: 'Description successfully updated'
    else
      render :edit
    end
  end

  private

  def applicants_pet_params
    params.require(:applicants_pet).permit(:adoption_description)
  end
end
