class Cmor::Cms::Folder < ActiveRecord::Base
  # associations
  has_many :cmor_cms_pages,
           class_name: 'Cmor::Cms::Page',
           dependent: :destroy,
           foreign_key: 'cmor_cms_folder_id'
  has_many :cmor_cms_partials,
           class_name: 'Cmor::Cms::Partial',
           dependent: :destroy,
           foreign_key: 'cmor_cms_folder_id'
  has_many :cmor_cms_templates,
           class_name: 'Cmor::Cms::Template',
           dependent: :destroy,
           foreign_key: 'cmor_cms_folder_id'

  # validations
  validates :basename, presence: true
  validates :pathname, presence: true
end
