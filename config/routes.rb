Rails.application.routes.draw do
  get ':short_url', to: 'url_shortener#code', constraint: { short_url: /[a-z]{3}[1-9]{3}/ }
  root to: 'url_shortener#index'
  post '/', to: 'url_shortener#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
