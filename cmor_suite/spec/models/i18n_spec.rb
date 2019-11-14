require 'rails_helper'

RSpec.describe 'Translations', type: :model do
  {
    ActiveStorage::Attachment       => {},
    ActiveStorage::Blob             => {},
    ActsAsTaggableOn::Tag           => {},
    ActsAsTaggableOn::Tagging       => {},
    Cmor::Blog::Post                => {},
    Cmor::Blog::AssetDetail         => {},
    Cmor::Cms::ContentBox           => {},
    Cmor::Cms::Navigation           => {},
    Cmor::Cms::NavigationItem       => {},
    Cmor::Cms::Page                 => {},
    Cmor::Cms::ContentBlock         => {},
    Cmor::Cms::Partial              => {},
    Cmor::Cms::Template             => {},
    Cmor::Contact::ContactRequest   => {},
    Cmor::Files::FileDetail         => {},
    Cmor::Files::Folder             => {},
    Cmor::Galleries::PictureDetail  => {},
    Cmor::Galleries::PictureGallery => {},
    Cmor::Links::Category           => {},
    Cmor::Links::Link               => {},
    Cmor::Partners::Category        => {},
    Cmor::Partners::Partner         => {},
    Cmor::Rbac::Permission          => {},
    Cmor::Rbac::Role                => {},
    Cmor::Rbac::RolePermission      => {},
    Cmor::Rbac::UserRole            => {},
    Cmor::Seo::Item                 => {},
    Cmor::Seo::MetaTag              => {},
    Cmor::Showcase::Category        => {},
    Cmor::Showcase::Item            => {},
    Cmor::Tags::Tag                 => {},
    Cmor::Tags::Tagging             => {},
    Cmor::UserArea::User            => {},
  }.each do |model, options|
    I18n.available_locales.each do |locale|
      I18n.locale = locale

      describe "for locale #{locale}:" do
        describe "#{model} translations" do
          it 'include one' do
            I18n.locale = locale
            i18n_key = ['activerecord', 'models', model.name.underscore].join('.')
            i18n_options = {}
            expect(I18n.translate!(i18n_key, options)[:one]).to be_a(String)
          end

          it 'include other' do
            I18n.locale = locale
            i18n_key = ['activerecord', 'models', model.name.underscore].join('.')
            i18n_options = {}
            expect(I18n.translate!(i18n_key, options)[:other]).to be_a(String)
          end

          describe 'for attributes' do

            model.column_names.each do |column_name|
              it "include #{column_name}" do
                I18n.locale = locale
                i18n_key = ['activerecord', 'attributes', model.name.underscore, column_name].join('.')
                expect(I18n.translate!(i18n_key)).to be_a(String)
              end
            end
          end
        end
      end
    end
  end
end
