require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class PodfileGenerator

		def generate(project_info)
			puts "\nGenerating Podfile".colorize(:yellow)

			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			
			# Generating Podfile
			file_builder = ProjectBuilder::FileBuilder.new
			file = "#{project_info.name}/Podfile"
			file_builder.build_file(
				file,
				templates_downloader.podfile, 
				project_info.hash_representation
			)

			# Installing pods
			puts 'Installing pods'.colorize(:yellow)
			script = 'bundle exec pod install'
			puts script.colorize(:green)
			
			`cd #{project_info.name} && #{script}`
		end

	end
end