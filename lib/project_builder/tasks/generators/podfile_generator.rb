require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class PodfileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			file_builder = ProjectBuilder::FileBuilder.new
						
			# Generating Podfile
			puts "\nGenerating Podfile".colorize(:yellow)

			file_builder.build_file(
				templates_downloader.podfile,
				"#{project_info.name}/Podfile",
				project_info.hash_representation
			)

			# Installing pods
			puts 'Installing pods'.colorize(:yellow)

			script = "cd #{project_info.name} && bundle exec pod install"
			puts script.colorize(:green)
			
			output = `#{script}`
			puts output
		end

	end
end