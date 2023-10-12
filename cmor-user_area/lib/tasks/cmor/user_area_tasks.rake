namespace :cmor do
  namespace :user_area do
    desc 'Creates the user with email/password. Defaults: email: "user@example.com", password: "password"'
    task create_user: [:environment] do
      email = ENV.fetch("email") { "user@example.com" }
      password = ENV.fetch("password") { "password" }
      Cmor::UserArea::CreateDefaultUserService.call(email: email, password: password, password_confirmation: password)
    end
  end
end
