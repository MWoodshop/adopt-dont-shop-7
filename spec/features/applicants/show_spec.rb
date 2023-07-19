require 'rails_helper'

RSpec.describe 'the applicant shows page' do
  it 'shows the applicant and all its attributes' do
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    visit applicant_path(@applicant1)
    expect(page).to have_content(@applicant1.name)
  end

  # User Story 4 Test
  it 'can search for a pet by name' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    expect(find('#search-pet-form')).to have_content('Add a Pet to this Application')
    expect(find('#search-pet-form')).to have_content('Pet:')
    expect(find('#search-pet-form')).to have_selector('input[name="pet_name"]')

    fill_in 'pet_name', with: 'Lucille Bald'
    click_button 'Search for Pet'

    expect(current_path).to eq(applicant_path(@applicant1))
    expect(page).to have_content('Lucille Bald')
  end

  # User Story 5 Test
  it 'can add a pet to an application' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    fill_in 'pet_name', with: 'Lucille Bald'
    click_button 'Search for Pet'

    expect(current_path).to eq(applicant_path(@applicant1))
    expect(page).to have_content('Matching Pets')
    expect(page).to have_css('.pet-name', text: 'Lucille Bald')
  end

  # User Story 6 Test
  it 'can submit an application' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)
    @pet2 = Pet.create!(adoptable: true, age: 2, breed: 'labrador', name: 'Clifford', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    fill_in 'pet_name', with: 'Lucille Bald'
    click_button 'Search for Pet'
    click_button 'Add Pet'
    visit applicant_path(@applicant1)
    fill_in 'applicant_description', with: 'I love dogs'

    click_button 'Submit this application'
    expect(current_path).to eq(applicant_path(@applicant1))
    expect(page).to have_content('Pending')
    expect(page).to have_content('Lucille Bald')
    fill_in 'pet_name', with: 'Clifford'
    click_button 'Search for Pet'
    expect(page).to have_content('Not available for adoption')
  end

  # User Story 7
  it 'can submit an application' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)
    @pet2 = Pet.create!(adoptable: true, age: 2, breed: 'labrador', name: 'Clifford', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    expect(page).not_to have_content('Submit this application')
  end

  # User Story 8 Test
  it 'can find a pet by partial search match' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    fill_in 'pet_name', with: 'Luc'
    click_button 'Search for Pet'

    expect(current_path).to eq(applicant_path(@applicant1))
    expect(page).to have_content('Matching Pets')
    expect(page).to have_css('.pet-name', text: 'Lucille Bald')
  end

  # User Story 9
  it 'can find a pet by partial search match' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    fill_in 'pet_name', with: 'lUciLLe bAlD'
    click_button 'Search for Pet'

    expect(current_path).to eq(applicant_path(@applicant1))
    expect(page).to have_content('Matching Pets')
    expect(page).to have_css('.pet-name', text: 'Lucille Bald')
  end
end
