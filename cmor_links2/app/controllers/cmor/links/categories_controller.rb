module Cmor::Links
  class CategoriesController < ApplicationController
    def index
      @categories = Category.includes(:links).all.decorate
    end

    def show
      @category = Category.includes(:links).find(params[:id]).decorate
    end
  end
end
