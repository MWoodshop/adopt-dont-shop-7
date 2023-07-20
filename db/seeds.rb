# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy existing records
ApplicantsPets.destroy_all
Applicant.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

# Create shelters
shelters = Shelter.create([
                            {
                              name: 'Happy Tails Shelter',
                              city: 'City 1',
                              foster_program: false,
                              rank: 1
                            },
                            {
                              name: 'Caturdays are for the Boys',
                              city: 'City 2',
                              foster_program: true,
                              rank: 2
                            },
                            {
                              name: 'Barking Lot',
                              city: 'City 3',
                              foster_program: true,
                              rank: 3
                            }
                          ])

# Create veterinary offices
veterinary_offices = VeterinaryOffice.create([
                                               {
                                                 name: 'Vet Office 1',
                                                 boarding_services: true,
                                                 max_patient_capacity: 50
                                               },
                                               {
                                                 name: 'Vet Office 2',
                                                 boarding_services: false,
                                                 max_patient_capacity: 30
                                               },
                                               {
                                                 name: 'Vet Office 3',
                                                 boarding_services: true,
                                                 max_patient_capacity: 40
                                               }
                                             ])

# Create veterinarians
veterinarians = Veterinarian.create([
                                      {
                                        name: 'Vet 1',
                                        veterinary_office: veterinary_offices.first,
                                        on_call: true,
                                        review_rating: 4
                                      },
                                      {
                                        name: 'Vet 2',
                                        veterinary_office: veterinary_offices.first,
                                        on_call: false,
                                        review_rating: 5
                                      },
                                      {
                                        name: 'Vet 3',
                                        veterinary_office: veterinary_offices.second,
                                        on_call: true,
                                        review_rating: 3
                                      }
                                    ])

# Create pets
pets = Pet.create([
                    {
                      name: 'Fluffy',
                      age: 2,
                      breed: 'Breed 1',
                      shelter: shelters.first,
                      adoptable: true
                    },
                    {
                      name: 'Spike',
                      age: 3,
                      breed: 'Breed 2',
                      shelter: shelters.second,
                      adoptable: false
                    },
                    {
                      name: 'Rex',
                      age: 4,
                      breed: 'Breed 3',
                      shelter: shelters.third,
                      adoptable: true
                    }
                  ])

# Create applicants
applicants = Applicant.create([
                                {
                                  name: 'Mike Wood',
                                  street_address: '123 Main St',
                                  city: 'City 1',
                                  state: 'State 1',
                                  zip_code: 12_345,
                                  description: 'Description 1',
                                  status: 'Pending'
                                },
                                {
                                  name: "John Clay O'Leary",
                                  street_address: '456 Elm St',
                                  city: 'City 2',
                                  state: 'State 2',
                                  zip_code: 67_890,
                                  status: 'In Progress'
                                },
                                {
                                  name: 'Jane Fonda',
                                  street_address: '789 Oak St',
                                  city: 'City 3',
                                  state: 'State 3',
                                  zip_code: 90_123,
                                  description: 'Description 3',
                                  status: 'Pending'
                                }
                              ])

# Assign 'Rex' to 'Caturdays are for the Boys' if it's not already assigned to a shelter
rex = Pet.find_by(name: 'Rex')
caturdays_shelter = Shelter.find_by(name: 'Caturdays are for the Boys')
rex.update(shelter: caturdays_shelter) unless rex.shelter.present?

# Assign 'Rex' to 'Jane Fonda' if the association doesn't already exist
rex = Pet.find_by(name: 'Rex')
jane_fonda = Applicant.find_by(name: 'Jane Fonda')
jane_fonda.applicants_pets.create(pet: rex) unless rex.applicants.include?(jane_fonda)

# Assign 'Rex' to 'Mike Wood' if the association doesn't already exist
rex = Pet.find_by(name: 'Rex')
mike_wood = Applicant.find_by(name: 'Mike Wood')
mike_wood.applicants_pets.create(pet: rex) unless rex.applicants.include?(mike_wood)

# Output a success message
puts 'Sample rows created successfully!'
