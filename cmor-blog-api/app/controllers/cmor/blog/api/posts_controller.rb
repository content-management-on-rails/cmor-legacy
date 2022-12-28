module Cmor::Blog::Api
  class PostsController < Cmor::Blog::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Blog::Post
    end
  end
end
