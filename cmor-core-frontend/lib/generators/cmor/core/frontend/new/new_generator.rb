module Cmor
  module Core
    module Frontend
      module Generators
        class NewGenerator < Rails::Generators::Base
          desc 'Creates a new frontend engine'

          source_root File.expand_path('../templates', __FILE__)

          class_option :name, type: 'string', aliases: '-n' # Cmor::Faq
          class_option :author, type: 'string', aliases: '-ga'
          class_option :email, type: 'string', aliases: '-gn'

          def generate_engine
            empty_directory "engines/#{flat_path}"
            templates_dir = "#{__dir__}/templates/"
            Dir.glob("#{templates_dir}**/*").each do |f|
              next unless File.file?(f)
              f.gsub!(templates_dir, '')
              target = build_target_filename(f)
              template f, "engines/#{flat_path}/#{target}"
            end
          end

          def set_permissions
            chmod "engines/#{flat_path}/initialize_dummy.sh", 0755
          end

          private

          def build_target_filename(f)
            if flat_filename_exceptions.include?(f)
              f.gsub("foo_bar", flat_path)
            else
              f.gsub('foo_bar', nested_path)
            end
          end

          def name
            @name ||= options[:name]
          end

          def nested_modules(options = nil)
            content = options.delete(:content)
            nm = ''
            s = name.split('::')
            nm << s.each_with_index.collect { |p,i| "#{ ' ' * (2 * i) }module #{p}\n" }.join
            nm << content.indent(s.size * 2) if content.present?
            (s.size - 1).downto(0) { |i| nm << "#{ ' ' * (2 * i) }end\n" }
            return nm
          end

          def nested_path
            @nested_path ||= name.underscore
          end

          def flat_path
            @flat_path ||= name.underscore.gsub('/', '_')
          end

          def flat_filename_exceptions
            %w(foo_bar.gemspec app/assets/javascripts/foo_bar.js app/assets/stylesheets/foo_bar.css lib/foo_bar.rb)
          end

          def gemspec
            {
              name: flat_path,
              authors: "[\"#{options[:author] || `git config user.name`.chomp }\"]",
              email: "[\"#{options[:email] || `git config user.email`.chomp }\"]"
            }
          end

          def cmor_version
            Cmor::VERSION
          end
        end
      end
    end
  end
end
