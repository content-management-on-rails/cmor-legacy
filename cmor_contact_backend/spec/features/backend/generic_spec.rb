require 'rails_helper'

DEFAULT_ACTIONS = [:index, :new, :create, :edit, :update, :delete]

{
  Cmor::Contact::Backend::Engine => {
    Cmor::Contact::Backend::ContactRequestsController => {
      actions: DEFAULT_ACTIONS,
      create_form: Proc.new { 
        attributes = attributes_for(:cmor_contact_contact_request)
        fill_in 'contact_request[name]', with: attributes[:name]
        fill_in 'contact_request[email]', with: attributes[:email]
        fill_in 'contact_request[phone]', with: attributes[:phone]
        fill_in 'contact_request[ip_address]', with: attributes[:ip_address]
        fill_in 'contact_request[message]', with: attributes[:message]
        check 'contact_request[accept_terms_of_service]'
      },
      update_form: Proc.new { 
        fill_in 'contact_request[name]', with: 'Jane Doe'
      },
    }
  }
}.each do |engine, controllers|
  I18n.available_locales.each do |locale|
    RSpec.describe engine.name, type: :feature do
      describe locale do
        before(:each) { I18n.locale = locale }

        let(:engine_route_name) { I18n.t("routes.#{engine.name.underscore.dasherize.gsub('/', '-')}") }
        let(:engine_path) { "/#{locale}/backend/#{engine_route_name}" }

        # let(:user) { create(:cmor_user_area_user, :authenticable) }

        describe 'dashboard access' do
          let(:dashboard_path) { engine_path }

          before(:each) do
            # sign_in(user)
            visit(dashboard_path)
          end

          it { expect(page.status_code).to eq(200) }
          it { expect(current_path).to eq(dashboard_path) }
        end

        controllers.each do |controller, options|

          describe controller.name do
            let(:resource_class) { controller.resource_class }
            let(:factory_name)   { resource_class.name.underscore.gsub('/', '_') }
            let(:base_path)      { "#{engine_path}/#{controller.resource_class.name.demodulize.underscore.pluralize}" }
            
            describe 'list' do
              before(:each) do
                # sign_in(user)
                visit(base_path)
              end

              it { expect(page.status_code).to eq(200) }
              it { expect(current_path).to eq(base_path) }
            end if options[:actions].include?(:index)

            describe 'list with record' do
              if options[:factory].respond_to?(:call)
                let(:record) { instance_eval(&options[:factory])  }
              else
                let(:record) { create(factory_name) }
              end
              
              before(:each) do
                # sign_in(user)
                record
                visit(base_path)
              end

              it { expect(page.status_code).to eq(200) }
              it { expect(current_path).to eq(base_path) }
            end if options[:actions].include?(:index)

            describe 'new' do
              let(:new_path)           { "#{base_path}/new" }
              let(:submit_button_text) { I18n.t('helpers.submit.create', model: resource_class.model_name.human) }

              before(:each) do
                # sign_in(user)
                visit(new_path)
              end

              it { expect(page.status_code).to eq(200) }
              it { expect(current_path).to eq(new_path) }
              it { expect(page.body).to have_xpath("//input[@type='submit' and @value='#{submit_button_text}']") }
            end if options[:actions].include?(:new)

            describe 'create' do
              let(:new_path)           { "#{base_path}/new" }
              let(:attributes)         { attributes_for(factory_name) }
              let(:form)               { options[:create_form] }
              let(:form_name)          { controller.resource_class.name.demodulize.underscore  }
              let(:show_path)          { "#{base_path}/#{controller.resource_class.last.to_param}" }
              let(:submit_button_text) { I18n.t('helpers.submit.create', model: resource_class.model_name.human) }
              let(:submit_button)      { find(:xpath, "//input[@type='submit' and @value='#{submit_button_text}']") }
              let(:success_message)    { I18n.t('flash.actions.create.notice', resource_name: resource_class.model_name.human) }
              let(:before_create_count) { controller.resource_class.count }

            before(:each) do
              # sign_in(user)
              before_create_count
              instance_eval(&options[:before_create]) if options[:before_create].respond_to?(:call)
              visit(new_path)
              instance_eval &form
              submit_button.click
            end

            it { expect(page.status_code).to eq(200) }
            it { expect(current_path).to eq(show_path) }
            it { expect(page.body).to have_text(success_message) }
            it { expect(controller.resource_class.count).to eq(before_create_count + 1) }
            end if options[:actions].include?(:create)

            describe 'show' do
              if options[:factory].respond_to?(:call)
                let(:record) { instance_eval(&options[:factory])  }
              else
                let(:record) { create(factory_name) }
              end
              let(:show_path) { "#{base_path}/#{record.to_param}" }

              before(:each) do
                record
                # sign_in(user)
                visit(show_path)
              end

              it { expect(page.status_code).to eq(200) }
              it { expect(current_path).to eq(show_path) }
            end if options[:actions].include?(:show)

            describe 'edit' do
              if options[:factory].respond_to?(:call)
                let(:record) { instance_eval(&options[:factory])  }
              else
                let(:record) { create(factory_name) }
              end
              let(:edit_path) { "#{base_path}/#{record.to_param}/edit" }

              before(:each) do
                record
                # sign_in(user)
                visit(edit_path)
              end

              it { expect(page.status_code).to eq(200) }
              it { expect(current_path).to eq(edit_path) }
            end if options[:actions].include?(:edit)

            describe 'update' do
              if options[:factory].respond_to?(:call)
                let(:record) { instance_eval(&options[:factory])  }
              else
                let(:record) { create(factory_name) }
              end
              let(:show_path)   { "#{base_path}/#{record.to_param}" }
              let(:edit_path)   { "#{show_path}/edit" }
              # let(:attributes)  { options[:update_attributes] }

              let(:form)               { options[:update_form]  }
              let(:form_name)          { controller.resource_class.name.demodulize.underscore  }
              let(:submit_button_text) { I18n.t('helpers.submit.update', model: resource_class.model_name.human) }
              let(:submit_button)      { find(:xpath, "//input[@type='submit' and @value='#{submit_button_text}']") }
              let(:success_message)    { I18n.t('flash.actions.update.notice', resource_name: resource_class.model_name.human) }

              describe 'ui' do
                before(:each) do
                  instance_eval(&options[:before_update]) if options[:before_update].respond_to?(:call)
                  # sign_in(user)
                  visit(edit_path)
                  instance_eval &form
                  submit_button.click
                end

                it { expect(page.status_code).to eq(200) }
                it { expect(current_path).to eq(show_path) }
                it { expect(page.body).to have_text(success_message) }
              end

              describe 'persistence changes' do
                before(:each) do
                  instance_eval(&options[:before_update]) if options[:before_update].respond_to?(:call)
                  # sign_in(user)
                  visit(edit_path)
                  instance_eval &form
                  submit_button.click                
                  record.reload
                end

                # options[:update_attributes].each do |key, value|
                #   it { expect(resource_class.last.send(key)).to eq(value) }
                # end
              end
            end if options[:actions].include?(:update)

            describe 'delete' do
              if options[:factory].respond_to?(:call)
                let(:record) { instance_eval(&options[:factory])  }
              else
                let(:record) { create(factory_name) }
              end
              let(:show_path)          { "#{base_path}/#{record.to_param}" }
              let(:delete_button_text) { I18n.t('itsf.backend.resource.base.show.destroy') }

              before(:each) do
                record
                # sign_in(user)
                visit(show_path)
                click_link(delete_button_text)
              end

              it { expect(page.status_code).to eq(200) }
              it { expect(current_path).to eq(base_path) }
            end if options[:actions].include?(:delete)
          end
        end
      end
    end
  end
end
