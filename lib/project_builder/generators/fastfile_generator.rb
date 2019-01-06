require 'fileutils'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class FastfileGenerator

		def generate(project_info)
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			file_builder = ProjectBuilder::FileBuilder.new

			# Creating fastlane directory
			fastlane_path = "#{project_info.name}/fastlane"
			FileUtils.mkdir_p fastlane_path

			fastlane_files = templates_downloader.fastlane_files 
			
			# Generating Fastfile
			puts "\nGenerating Fastfile".colorize(:yellow)

			fastfile = "#{fastlane_path}/Fastfile"
			file_builder.build_file(
				fastfile,
				fastlane_files['fastfile'],
				project_info.hash_representation
			)

			# Generating Appfile
			puts "\nGenerating Appfile".colorize(:yellow)
			
			appfile = "#{fastlane_path}/Appfile"
			properties = project_info.hash_representation
			properties['user'] = {'email' => `git config user.email`.delete!("\n")}
			file_builder.build_file(
				appfile,
				fastlane_files['appfile'],
				properties
			)
		end

	end
end