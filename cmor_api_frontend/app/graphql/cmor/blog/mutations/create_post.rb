module Cmor
  module Blog
    module Motations
      class CreatePost < Mutations::BaseMutation
        null true

        argument :body, String, required: true
        argument :post_id, ID, required: true

        field :comment, Types::Comment, null: true
        field :errors, [String], null: false

        def resolve(body:, post_id:)
          post = Post.find(post_id)
          comment = post.comments.build(body: body, author: context[:current_user])
          if comment.save
            # Successful creation, return the created object with no errors
            {
              comment: comment,
              errors: [],
            }
          else
            # Failed save, return the errors to the client
            {
              comment: nil,
              errors: comment.errors.full_messages
            }
          end
        end
      end
    end
  end
end
