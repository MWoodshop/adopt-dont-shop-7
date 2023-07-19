require 'rails_helper'

RSpec.describe 'the admin/shelters' do
  # User Story 10 Test
  it 'lists all the shelters with their attributes in reverse alphabetical order' do
    shelter1 = Shelter.create(
      name: 'Aurora Shelter',
      city: 'Aurora, CO',
      foster_program: false,
      rank: 9
    )

    shelter2 = Shelter.create(
      name: 'Beggin Strips Shelter',
      city: 'Howell, NJ',
      foster_program: true,
      rank: 10
    )

    shelter3 = Shelter.create(
      name: 'Cookies for Days Shelter',
      city: 'Los Angeles, CA',
      foster_program: false,
      rank: 11
    )

    visit '/admin/shelters'
    expect(page).to have_content(shelter3.name)
    expect(page).to have_content(shelter2.name)
    expect(page).to have_content(shelter1.name)

    expect(shelter3.name).to appear_before(shelter2.name)
    expect(shelter2.name).to appear_before(shelter1.name)
  end

  # User Story 11 Test
  it 'lists all the shelters with pending applications' do
    shelter1 = Shelter.create(
      name: 'Aurora Shelter',
      city: 'Aurora, CO',
      foster_program: true,
      rank: 9
    )

    shelter2 = Shelter.create(
      name: 'Beggin Strips Shelter',
      city: 'Howell, NJ',
      foster_program: false,
      rank: 10
    )

    pet1 = Pet.create(
      name: 'Dr. Dog',
      age: 3,
      breed: 'Husky',
      shelter: shelter1,
      adoptable: true
    )

    applicant1 = Applicant.create(
      name: 'John Smith',
      street_address: '1234 Example St',
      city: 'Longmont',
      state: 'CO',
      zip_code: '80503',
      description: 'I love pets!'
    )

    ApplicantsPet.create(applicant: applicant1, pet: pet1)
    applicant1.reload

    visit "/pets/#{pet1.id}"
    expect(page).to have_content("Shelter Name: #{shelter1.name}")

    visit "/applicants/#{applicant1.id}"
    expect(page).to have_content('Status: Pending')

    visit '/admin/shelters'
    within('#pending-applications-title + p', text: shelter1.name) do
      expect(page).to have_content(shelter1.name)
    end
  end
end
