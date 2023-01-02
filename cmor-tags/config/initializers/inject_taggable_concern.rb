Rails.configuration.to_prepare do
  Cmor::Tags::Configuration.taggable_classes.each do |taggable|
    print "[Cmor::Tags] Including Model::Cmor::Tags::TaggableConcern into #{taggable}"
    taggable.send(:include, Model::Cmor::Tags::TaggableConcern)
    puts " => OK"
  end
end
