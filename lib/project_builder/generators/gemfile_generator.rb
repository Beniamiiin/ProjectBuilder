require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class GemfileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			
			file_builder = ProjectBuilder::FileBuilder.new
			file = "#{project_info.name}/Gemfile"
			file_builder.build_file(
				file,
				templates_downloader.gemfile, 
				project_info.hash_representation
			)

			`cd #{project_info.name} && bundle install`
		end

	end
end