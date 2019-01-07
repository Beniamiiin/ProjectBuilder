require 'fileutils'
require 'colorize'

require 'project_builder/helpers/templates_downloader'
require 'project_builder/helpers/file_builder'

require 'project_builder/models/project_info'

module ProjectBuilder
	class ProjectGenerator
		
		def generate(project_info)
			@project_info = project_info
			@templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			@file_builder = ProjectBuilder::FileBuilder.new

			puts "\nGenerating project".colorize(:yellow)

			create_project_file
			create_project_file_structure

			# Generating xcodeproj file
			puts 'Generating xcodeproj file'.colorize(:yellow)

			script = "xcodegen generate --spec #{project_info.name}/project.yml"
			puts script.colorize(:green)

			output = `#{script}`
			puts output
		end

		private

		def create_project_file
			@file_builder.build_file(
				@templates_downloader.project_file,
				"#{@project_info.name}/project.yml",
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
			root_directory = "#{@project_info.name}/#{@project_info.name}"
			Dir.glob("#{code}/**/*/").each do |directory|
				directory_path = directory.sub("#{code}/", '')
				next if directory_path.empty?
				directory_path = "#{root_directory}/#{directory_path}"
				
				FileUtils.mkdir_p directory_path
				
				# Generating files
				Dir.glob("#{directory}*.liquid").each do |template_file|
					file_path = template_file.sub("#{code}/", '').sub('.liquid', '')
					next if file_path.empty?
					file_path = "#{root_directory}/#{file_path}"

					properties['file_name'] = File.basename(file_path)
					@file_builder.build_file(template_file, file_path, properties)
				end
			end
		end

	end
end