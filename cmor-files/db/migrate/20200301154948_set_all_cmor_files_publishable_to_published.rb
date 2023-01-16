class SetAllCmorFilesPublishableToPublished < ActiveRecord::Migration[5.2]
  def self.up
    ActiveRecord::Base.transaction do
      [
        Cmor::Files::FileDetail
      ].each do |klass|
        klass.update_all(published_at: Time.zone.now)
      end
    end
  end

  def down.up
    ActiveRecord::Base.transaction do
      [
        Cmor::Files::FileDetail
      ].each do |klass|
        klass.update_all(published_at: nil)
      end
    end
  end
end
