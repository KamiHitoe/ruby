Rails.application.routes.draw do
  get "/", to: "home#index"
  get "/hello", to: "hellos#index"
end
