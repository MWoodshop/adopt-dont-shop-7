require 'rails_helper'

RSpec.describe 'ApplicantsPets', type: :feature do
  before :each do
    @applicant = Applicant.create!(name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                   zip_code: '58200')
    @shelter = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @pet = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter)
  end

  it 'creates a new association between an applicant and a pet' do
    visit applicant_path(@applicant)

    fill_in 'pet_name', with: @pet.name
    click_button 'Search for Pet'
    click_button 'Add Pet'

    expect(page).to have_content(@pet.name)
  end
end
