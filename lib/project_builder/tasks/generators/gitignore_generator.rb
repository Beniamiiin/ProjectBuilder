require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class GitignoreGenerator

		def generate(project_info)
			puts "\nGenerating .gitignore".colorize(:yellow)

			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			
			# Generating .gitignore
			file_builder = ProjectBuilder::FileBuilder.new
			file = "#{project_info.name}/.gitignore"
			file_builder.build_file(file, templates_downloader.gitignore)
		end

	end
end