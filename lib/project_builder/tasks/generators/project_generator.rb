require 'fileutils'
require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class ProjectGenerator
		
		def generate(project_info)
			puts "\nGenerating project".colorize(:yellow)

			@project_info = project_info
			@templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			@file_builder = ProjectBuilder::FileBuilder.new

			create_project_file
			create_project_file_structure

			# Generating xcodeproj file
			puts 'Generating xcodeproj file'.colorize(:yellow)
			script = 'xcodegen generate'
			puts script.colorize(:green)

			`cd #{project_info.name} && #{script}`
		end

		private

		def create_project_file
			file = "#{@project_info.name}/project.yml"
			@file_builder.build_file(
				file,
				@templates_downloader.project_file,
				@project_info.hash_representation
			)
		end

		def create_project_file_structure
			code = "#{@templates_downloader.project_files_directory_path}/Code"
			snippets = "#{@templates_downloader.project_files_directory_path}/snippets"

			Liquid::Template.file_system = Liquid::LocalFileSystem.new(snippets, '%s.liquid')

			properties = @project_info.hash_representation
			properties['user'] = {
				'name' => `git config user.name`.delete!("\n"),
				'email' => `git config user.email`.delete!("\n")
			}
			properties['date'] = Time.now.strftime("%d/%m/%Y")
			properties['year'] = Time.now.strftime("%Y")

			# Creating directories
			Dir.glob("#{code}/**/*/").each do |directory|
				path = directory.sub("#{code}/", '')
				next if path.empty?
				path = "#{@project_info.name}/#{@project_info.name}/#{path}"
				
				FileUtils.mkdir_p path

				# Generating files
				Dir.glob("#{directory}*.liquid").each do |file|
					path = file.sub("#{code}/", '').sub('.liquid', '')
					next if path.empty?
					path = "#{@project_info.name}/#{@project_info.name}/#{path}"

					properties['file_name'] = File.basename(path)
					@file_builder.build_file(path, file, properties)
				end
			end
		end

	end
end