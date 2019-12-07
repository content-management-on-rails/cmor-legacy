module Cmor
  module Api
    module Backend
      class Mutations < GraphQL::Schema::Object
        {
          'Cmor::Blog::Backend::Mutations::CreatePost' => { field_name: :create_post },
          'Cmor::Blog::Backend::Mutations::UpdatePost' => { field_name: :update_post },
          'Cmor::Blog::Backend::Mutations::DeletePost' => { field_name: :delete_post },
          'Cmor::Cms::Backend::Mutations::CreatePage' => { field_name: :create_page },
          'Cmor::Cms::Backend::Mutations::UpdatePage' => { field_name: :update_page },
          'Cmor::Cms::Backend::Mutations::DeletePage' => { field_name: :delete_page },
          'Cmor::UserArea::Backend::Mutations::CreateUser' => { field_name: :create_user },
          'Cmor::UserArea::Backend::Mutations::UpdateUser' => { field_name: :update_user },
          'Cmor::UserArea::Backend::Mutations::DeleteUser' => { field_name: :delete_user },
        }.each do |class_name, options|
          field options[:field_name], mutation: class_name.constantize
        end
      end
    end
  end
end
