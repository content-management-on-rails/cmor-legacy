class Cmor::Cms::Navigation < ActiveRecord::Base
  # associations
  has_many :navigation_items,
    dependent: :destroy do
    def published
      merge(Cmor::Cms::NavigationItem.published)
    end
  end

  # validations
  validates :locale, inclusion: I18n.available_locales.map(&:to_s),
    allow_nil: true,
    allow_blank: true
  validates :name, presence: true,
    uniqueness: {scope: [:locale]}

  delegate :count, to: :navigation_items, prefix: true

  def human
    "#{name} (#{locale})"
  end
end
