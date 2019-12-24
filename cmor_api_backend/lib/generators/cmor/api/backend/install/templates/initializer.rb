Rails.application.config.to_prepare do
  Cmor::Api::Backend.configure do |config|
    config.mutations = {
      'Cmor::Blog::Backend::Mutations::CreatePost' => { field_name: :create_post },
      'Cmor::Blog::Backend::Mutations::UpdatePost' => { field_name: :update_post },
      'Cmor::Blog::Backend::Mutations::DeletePost' => { field_name: :delete_post },
      'Cmor::Cms::Backend::Mutations::CreatePage' => { field_name: :create_page },
      'Cmor::Cms::Backend::Mutations::UpdatePage' => { field_name: :update_page },
      'Cmor::Cms::Backend::Mutations::DeletePage' => { field_name: :delete_page },
      'Cmor::UserArea::Backend::Mutations::CreateUser' => { field_name: :create_user },
      'Cmor::UserArea::Backend::Mutations::UpdateUser' => { field_name: :update_user },
      'Cmor::UserArea::Backend::Mutations::DeleteUser' => { field_name: :delete_user }
    }

    config.models = %w(
      Cmor::Blog::Post
      Cmor::UserArea::User
      Cmor::Cms::Page
    )

    config.services = {
      'Cmor::UserArea::Backend::Mutations::CallCreateDefaultUserService' => { field_name: :call_create_default_user_service }
    }
  end
end