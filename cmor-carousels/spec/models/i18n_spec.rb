require "rails_helper"

RSpec.describe "Translations", type: :model do
  {
    Cmor::Carousels::Carousel => {},
    Cmor::Carousels::ItemDetail => {}
  }.each do |model, options|
    I18n.available_locales.each do |locale|
      I18n.locale = locale

      describe "for locale #{locale}:" do
        describe "#{model} translations" do
          it "include one" do
            I18n.locale = locale
            i18n_key = ["activerecord", "models", model.name.underscore].join(".")
            expect(I18n.translate!(i18n_key, **options)[:one]).to be_a(String)
          end

          it "include other" do
            I18n.locale = locale
            i18n_key = ["activerecord", "models", model.name.underscore].join(".")
            expect(I18n.translate!(i18n_key, **options)[:other]).to be_a(String)
          end

          describe "for attributes" do
            model.column_names.each do |column_name|
              it "include #{column_name}" do
                I18n.locale = locale
                i18n_key = ["activerecord", "attributes", model.name.underscore, column_name].join(".")
                expect(I18n.translate!(i18n_key)).to be_a(String)
              end
            end
          end
        end
      end
    end
  end
end
