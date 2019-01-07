require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class RambafileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			file_builder = ProjectBuilder::FileBuilder.new

			# Generating Rambafile
			puts "\nGenerating Rambafile".colorize(:yellow)

			file_builder.build_file(
				templates_downloader.rambafile,
				"#{project_info.name}/Rambafile",
				project_info.hash_representation
			)

			# Downloading generamba templates
			puts 'Downloading generamba templates'.colorize(:yellow)
			
			script = "cd #{project_info.name} && bundle exec generamba template install"
			puts script.colorize(:green)
			
			output = `#{script}`
			puts output
		end

	end
end