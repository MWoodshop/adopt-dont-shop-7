class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new; end

  def create
    puts "Received params: #{params.inspect}"
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to applicant_path(@applicant)
    else
      flash[:error] = 'Invalid data. Please fill out fields correctly.'
      redirect_to new_applicant_path
    end
  end

  # User Story 9 and 10
  def show
    @applicant = Applicant.find(params[:id])
    pet_name = params[:pet_name]&.downcase

    @matching_pets = if pet_name.present?
                       Pet.where('lower(name) ILIKE ?', "%#{pet_name}%")
                     else
                       []
                     end

    @associated_pets = @applicant.pets
    @applicants_pet = ApplicantsPet.find_or_initialize_by(applicant: @applicant)

    # Check if any pets are added to the applicant and update the status if necessary
    return unless @applicant.pets.present? && @applicant.status == 'In Progress'

    @applicant.update(status: 'Pending')
  end

  # ***
  # Remove if no longer used
  # ***
  # def search
  #   @applicant = Applicant.find(params[:id])
  #   @matching_pets = Pet.where('name LIKE ?', "%#{params[:pet_name]}%")
  #   render 'search'
  # end

  def update
    @applicant = Applicant.find(params[:id])

    if @applicant.update(applicant_params)
      redirect_to applicant_path(@applicant)
    else
      flash[:error] = 'Invalid data. Please fill out fields correctly.'
      render :show
    end
  end

  private

  def applicant_params
    params.require(:applicant).permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
