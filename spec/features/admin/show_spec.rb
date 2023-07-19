require 'rails_helper'

RSpec.describe 'the admin/applicants/applicant_id' do
  # User Story 12 Test
  it 'shows an approve applicant button' do
    shelter1 = Shelter.create(
      name: 'Aurora Shelter',
      city: 'Aurora, CO',
      foster_program: false,
      rank: 9
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

    visit "/admin/applicants/#{applicant1.id}"
    expect(page).to have_button('Approve Adoption', class: 'approve-button')
    click_button 'Approve Adoption'
    expect(page).not_to have_button('Approve Adoption', class: 'approve-button')
    expect(page).to have_content('Status: Approved')
  end

  # User Story 13 Test
  it 'shows a reject applicant button' do
    shelter1 = Shelter.create(
      name: 'Aurora Shelter',
      city: 'Aurora, CO',
      foster_program: false,
      rank: 9
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

    visit "/admin/applicants/#{applicant1.id}"
    expect(page).to have_button('Reject Adoption', class: 'reject-button')
    click_button 'Reject Adoption'
    expect(page).not_to have_button('Reject Adoption', class: 'reject-button')
    expect(page).to have_content('Status: Rejected')
  end

  # User Story 14 Test
  it 'approval or rejection of one applicant does not affect a pet on another applicant' do
    shelter1 = Shelter.create(
      name: 'Aurora Shelter',
      city: 'Aurora, CO',
      foster_program: false,
      rank: 9
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
    applicant2 = Applicant.create(
      name: 'Jane Smith',
      street_address: '1234 Test St',
      city: 'Howell',
      state: 'NJ',
      zip_code: '08759',
      description: 'I love pets more!'
    )
    ApplicantsPet.create(applicant: applicant1, pet: pet1)
    ApplicantsPet.create(applicant: applicant2, pet: pet1)

    applicant1.reload
    applicant2.reload

    visit "/pets/#{pet1.id}"
    expect(page).to have_content("Shelter Name: #{shelter1.name}")

    visit "/applicants/#{applicant1.id}"
    expect(page).to have_content('Status: Pending')

    visit "/applicants/#{applicant2.id}"
    expect(page).to have_content('Status: Pending')

    visit '/admin/shelters'
    within('#pending-applications-title + p', text: shelter1.name) do
      expect(page).to have_content(shelter1.name)
    end

    visit "/admin/applicants/#{applicant1.id}"
    expect(page).to have_button('Reject Adoption', class: 'reject-button')
    click_button 'Reject Adoption'
    expect(page).not_to have_button('Reject Adoption', class: 'reject-button')
    expect(page).to have_content('Status: Rejected')

    visit "/admin/applicants/#{applicant2.id}"
    expect(page).to have_button('Approve Adoption', class: 'approve-button')
    click_button 'Approve Adoption'
    expect(page).not_to have_button('Approve Adoption', class: 'approve-button')
    expect(page).to have_content('Status: Approved')
  end
end
