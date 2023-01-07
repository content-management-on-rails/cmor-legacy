class SetAllPublishableToPublished < ActiveRecord::Migration[5.2]
  def self.up
    ActiveRecord::Base.transaction do
      [
        Cmor::Cms::NavigationItem,
        Cmor::Cms::Page,
        Cmor::Cms::Partial,
        Cmor::Cms::Template
      ].each do |klass|
        klass.update_all(published_at: Time.zone.now)
      end
    end
  end

  def down.up
    ActiveRecord::Base.transaction do
      [
        Cmor::Cms::NavigationItem,
        Cmor::Cms::Page,
        Cmor::Cms::Partial,
        Cmor::Cms::Template
      ].each do |klass|
        klass.update_all(published_at: nil)
      end
    end
  end
end
