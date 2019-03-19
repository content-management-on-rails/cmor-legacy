class Cmor::Cms::Navigation < ActiveRecord::Base
  # associations
  has_many :cmor_cms_navigation_items,
           class_name: 'Cmor::Cms::NavigationItem',
           dependent: :destroy,
           foreign_key: 'cmor_cms_navigation_id'

  # validations
  validates :locale, inclusion: I18n.available_locales.map(&:to_s),
                     allow_nil: true,
                     allow_blank: true
  validates :name, presence: true,
                   uniqueness: { scope: [:locale] }

  delegate :count, to: :cmor_cms_navigation_items, prefix: true

  def human
    "#{name} (#{locale})"
  end
end
