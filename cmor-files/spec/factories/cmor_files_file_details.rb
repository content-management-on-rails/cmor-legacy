FactoryBot.define do
  factory :cmor_files_file_detail, class: "Cmor::Files::FileDetail" do
    association :folder, factory: :cmor_files_folder
    asset { Rack::Test::UploadedFile.new(File.open(Cmor::Files::Engine.root.join(*%w[spec files cmor files file_details example.png]))) }
  end
end
