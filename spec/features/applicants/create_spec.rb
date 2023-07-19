require 'rails_helper'

RSpec.describe 'applicant form' do
  describe 'applicant new' do
    it 'renders the new form' do
      visit '/applicants/new'

      expect(page).to have_content('New Applicant')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'applicant create' do
    context 'given valid data' do
      it 'creates the applicant' do
        visit '/applicants/new'

        fill_in 'Name', with: 'John Doe'
        fill_in 'Street address', with: '123 Main St'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip code', with: 80_202
        click_button 'Save'

        expect(current_path).to eq(applicant_path(Applicant.last))
        expect(page).to have_content('John Doe')
        expect(page).to have_content('123 Main St')
        expect(page).to have_content('Denver')
        expect(page).to have_content('CO')
        expect(page).to have_content(80_202)
        expect(page).to have_text('In Progress')
      end

      context 'given invalid data' do
        it 'creates the applicant' do
          visit '/applicants/new'

          fill_in 'Name', with: 'John Doe'
          fill_in 'Street address', with: '123 Main St'
          fill_in 'City', with: 'Denver'
          fill_in 'State', with: 'CO'
          fill_in 'Zip code', with: 'Denver'
          click_button 'Save'

          expect(current_path).to eq('/applicants/new')
          expect(page).to have_content('Invalid data. Please fill out fields correctly')
        end
      end
    end
  end
end
