require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class RambafileGenerator

		def generate(project_info)
			puts "\nGenerating Rambafile".colorize(:yellow)

			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			
			file_builder = ProjectBuilder::FileBuilder.new
			file = "#{project_info.name}/Rambafile"
			file_builder.build_file(
				file,
				templates_downloader.rambafile, 
				project_info.hash_representation
			)

			puts 'Downloading generamba templates'.colorize(:yellow)
			script = 'bundle exec generamba template install'
			puts script.colorize(:green)
			`cd #{project_info.name} && #{script}`
		end

	end
end