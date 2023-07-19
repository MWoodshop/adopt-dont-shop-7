Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  get '/applicants', to: 'applicants#index', as: 'applicants'
  get '/applicants/:id/search', to: 'applicants#search', as: 'applicant_search'
  get '/applicants/new', to: 'applicants#new', as: 'new_applicant'
  get '/applicants/:id', to: 'applicants#show', as: 'applicant'
  post '/applicants', to: 'applicants#create', as: 'create_applicant'
  get '/applicants/:id/edit', to: 'applicants#edit', as: 'edit_applicant'
  patch '/applicants/:id', to: 'applicants#update', as: 'update_applicant'
  delete '/applicants/:id', to: 'applicants#destroy', as: 'delete_applicant'

  # Add a pet to an applicant
  post '/applicants/:applicant_id/pets/:pet_id', to: 'applicants_pets#create', as: 'create_applicant_pet'
  patch '/applicants_pets/:id/update_adoption_description', to: 'applicants_pets#update_adoption_description',
                                                            as: 'update_adoption_description_applicants_pet'

  get '/shelters', to: 'shelters#index', as: 'shelters'
  get '/shelters/new', to: 'shelters#new', as: 'new_shelter'
  get '/shelters/:id', to: 'shelters#show', as: 'shelter'
  post '/shelters', to: 'shelters#create', as: 'create_shelter'
  get '/shelters/:id/edit', to: 'shelters#edit', as: 'edit_shelter'
  patch '/shelters/:id', to: 'shelters#update', as: 'update_shelter'
  delete '/shelters/:id', to: 'shelters#destroy', as: 'delete_shelter'

  get '/pets', to: 'pets#index', as: 'pets'
  get '/pets/new', to: 'pets#new', as: 'new_pet'
  get '/pets/:id', to: 'pets#show', as: 'pet'
  get '/pets/:id/edit', to: 'pets#edit', as: 'edit_pet'
  patch '/pets/:id', to: 'pets#update', as: 'update_pet'
  delete '/pets/:id', to: 'pets#destroy', as: 'delete_pet'

  get '/veterinary_offices', to: 'veterinary_offices#index', as: 'veterinary_offices'
  get '/veterinary_offices/new', to: 'veterinary_offices#new', as: 'new_veterinary_office'
  get '/veterinary_offices/:id', to: 'veterinary_offices#show', as: 'veterinary_office'
  post '/veterinary_offices', to: 'veterinary_offices#create', as: 'create_veterinary_office'
  get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit', as: 'edit_veterinary_office'
  patch '/veterinary_offices/:id', to: 'veterinary_offices#update', as: 'update_veterinary_office'
  delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy', as: 'delete_veterinary_office'

  get '/veterinarians', to: 'veterinarians#index', as: 'veterinarians'
  get '/veterinarians/:id', to: 'veterinarians#show', as: 'veterinarian'
  get '/veterinarians/:id/edit', to: 'veterinarians#edit', as: 'edit_veterinarian'
  patch '/veterinarians/:id', to: 'veterinarians#update', as: 'update_veterinarian'
  delete '/veterinarians/:id', to: 'veterinarians#destroy', as: 'delete_veterinarian'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets', as: 'shelter_pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new', as: 'new_shelter_pet'
  post '/shelters/:shelter_id/pets', to: 'pets#create', as: 'create_shelter_pet'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians',
                                                                 as: 'veterinary_office_veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new',
                                                                     as: 'new_veterinary_office_veterinarian'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create',
                                                                  as: 'create_veterinary_office_veterinarian'
  get '/admin', to: 'admin/admin#welcome', as: 'admin_root'
  get '/admin/shelters', to: 'admin/shelters#index', as: 'admin_shelters'
  get '/admin/applicants', to: 'admin/applicants#index', as: 'admin_applicants'
  get '/admin/applicants/:id', to: 'admin/applicants#show', as: 'admin_applicant'
  get '/admin/applicants/:id/search', to: 'applicants#search', as: 'admin_applicant_search'
  patch '/applicants/:applicant_id/pets/:pet_id/approve', to: 'admin/applicants#approve_pet',
                                                          as: 'approve_applicant_pet'
  patch '/applicants/:applicant_id/pets/:pet_id/reject', to: 'admin/applicants#reject_pet',
                                                         as: 'reject_applicant_pet'
end
