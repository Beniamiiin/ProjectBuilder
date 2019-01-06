require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class PodfileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.new
			
			file_builder = ProjectBuilder::FileBuilder.new
			file = "#{project_info.name}/Podfile"
			file_builder.build_file(
				file,
				templates_downloader.podfile, 
				project_info.hash_representation
			)

			`cd #{project_info.name} && bundle exec pod install`
		end

	end
end