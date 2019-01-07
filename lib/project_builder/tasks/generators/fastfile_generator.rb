require 'fileutils'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class FastfileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			file_builder = ProjectBuilder::FileBuilder.new
			fastlane_files = templates_downloader.fastlane_files
			
			# Creating fastlane directory
			fastlane_path = "#{project_info.name}/fastlane"
			FileUtils.mkdir_p fastlane_path

			# Generating Fastfile
			puts "\nGenerating Fastfile".colorize(:yellow)

			file_builder.build_file(
				fastlane_files['fastfile'],
				"#{fastlane_path}/Fastfile",
				project_info.hash_representation
			)

			# Generating Appfile
			puts "Generating Appfile".colorize(:yellow)
			
			properties = project_info.hash_representation
			properties['user'] = {'email' => `git config user.email`.delete!("\n")}
			file_builder.build_file(
				fastlane_files['appfile'],
				"#{fastlane_path}/Appfile",
				properties
			)
		end

	end
end