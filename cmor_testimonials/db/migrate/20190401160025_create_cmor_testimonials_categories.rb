class CreateCmorTestimonialsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_testimonials_categories do |t|
      t.string :identifier

      t.timestamps
    end
  end
end
