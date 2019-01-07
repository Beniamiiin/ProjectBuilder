require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class GemfileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			file_builder = ProjectBuilder::FileBuilder.new
						
			# Generating Gemfile
			puts "\nGenerating Gemfile".colorize(:yellow)

			file_builder.build_file(
				templates_downloader.gemfile,
				"#{project_info.name}/Gemfile",
				project_info.hash_representation
			)

			# Installing gems
			puts 'Installing gems'.colorize(:yellow)

			script = "bundle install --gemfile #{project_info.name}/Gemfile"
			puts script.colorize(:green)
			
			output = `#{script}`
			puts output
		end

	end
end