Rails.configuration.to_prepare do
  Cmor::Tags::Configuration.taggable_classes.each do |taggable|
    puts "Including Model::Cmor::Tags::TaggableConcern in #{taggable}"
    taggable.send(:include, Model::Cmor::Tags::TaggableConcern)
  end
end