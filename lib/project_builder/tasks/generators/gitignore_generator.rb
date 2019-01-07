require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class GitignoreGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			file_builder = ProjectBuilder::FileBuilder.new
						
			# Generating .gitignore
			puts "\nGenerating .gitignore".colorize(:yellow)

			file_builder.build_file(
				templates_downloader.gitignore,
				"#{project_info.name}/.gitignore"
			)
		end

	end
end