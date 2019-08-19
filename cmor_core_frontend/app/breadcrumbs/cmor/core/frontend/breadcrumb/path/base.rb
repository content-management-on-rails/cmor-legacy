module Cmor
  module Core
    module Frontend
      module Breadcrumb
        module Path
          # You can specify custom breadcrumbs at controller/action level.
          #
          # Example:
          #
          # Assume you have a PostsController with an index action and you want
          # to change its breadcrumb. You will have to create a class that
          # inherits from Cmor::Core::Frontend::Breadcrumb::Path::Base. This
          # class has to have a breadcrumbs methods that returns an array of
          # Cmor::Core::Frontend::Breadcrumb::Base.
          #
          #     # app/breadcrumbs/posts_controller/index_breadcrumb_path.rb
          #     class PostsController::IndexBreadcrumbPath < Cmor::Core::Frontend::Breadcrumb::Path::Base
          #       def breadcrumbs
          #         [
          #           Cmor::Core::Frontend::Breadcrumb::Base.new(title: 'Foo', url: '/foo' ),
          #           Cmor::Core::Frontend::Breadcrumb::Base.new(title: 'Bar', url: '/bar' )
          #         ]
          #       end
          #     end
          #
          class Base
            extend ActiveModel::Model
            include I18nConcern

            attr_accessor :context

            def initialize(attrs)
              attrs.each do |k, v|
                self.send("#{k}=", v)
              end
            end

            def breadcrumbs
              raise "Child class reponsibility"
            end
          end
        end
      end
    end
  end
end