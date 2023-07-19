class Admin::ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new; end

  def show
    @applicant = Applicant.find(params[:id])
    pet_name = params[:pet_name]&.downcase

    @associated_pets = @applicant.pets
    @applicants_pet = ApplicantsPet.find_or_initialize_by(applicant: @applicant)

    # Check if any pets are added to the applicant and update the status if necessary
    @applicant.update(status: 'Pending') if @applicant.pets.present? && @applicant.status == 'In Progress'

    # Handle approving the pet
    return unless params[:pet_id].present?

    pet = Pet.find(params[:pet_id])
    applicants_pet = ApplicantsPet.find_by(applicant: @applicant, pet:)
    applicants_pet&.update(status: 'Approved')

    # Handle rejecting the pet
    return unless params[:reject_pet_id].present?

    pet = Pet.find(params[:reject_pet_id])
    applicants_pet = ApplicantsPet.find_by(applicant: @applicant, pet:)
    applicants_pet&.update(status: 'Rejected')
  end

  def approve_pet
    @applicant = Applicant.find(params[:applicant_id])
    @applicant.update(status: 'Approved')
    redirect_to admin_applicant_path(@applicant)
  end

  def reject_pet
    @applicant = Applicant.find(params[:applicant_id])
    @applicant.update(status: 'Rejected')
    redirect_to admin_applicant_path(@applicant)
  end

  private

  def applicant_params
    params.require(:applicant).permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
