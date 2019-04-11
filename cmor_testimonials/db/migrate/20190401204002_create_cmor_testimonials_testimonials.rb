class CreateCmorTestimonialsTestimonials < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_testimonials_testimonials do |t|
      t.references :category, foreign_key: false
      t.string :fullname
      t.string :role
      t.string :company
      t.text :body
      t.integer :position
      t.timestamp :published_at

      t.timestamps
    end
  end
end
