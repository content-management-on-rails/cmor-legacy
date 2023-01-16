class AddUserstampsToCmorSeoItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :cmor_seo_items, :created_by, null: true, index: true, foreign_key: false
    add_reference :cmor_seo_items, :updated_by, null: true, index: true, foreign_key: false
  end
end
