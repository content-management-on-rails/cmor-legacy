module Cmor
  module Core
    module Api
      module ResourcesController
        module SortingConcern
          private

          def load_collection_scope
            add_order_scope(super)
          end

          def add_order_scope(base_scope)
            if params[:sort_by].present?
              if params[:sort_by].include?(' ') || params[:sort_direction].include?(' ')
                raise "Possible SQL Injection attempt while trying to sort by #{params[:sort_by]} #{params[:sort_direction]}"
              end

              sort_by        = params[:sort_by]
              sort_direction = (params[:sort_direction] || :asc)

              if sort_by.include?('.')
                base_scope.reorder("#{sort_by} #{sort_direction}")
              else
                base_scope.reorder(sort_by => sort_direction)
              end
            else
              base_scope
            end
          end
        end
      end
    end
  end
end
