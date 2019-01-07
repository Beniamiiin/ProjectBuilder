require 'thor'
require 'fileutils'

require 'project_builder/helpers/dependency_checker'
require 'project_builder/helpers/dependency_installer'
require 'project_builder/helpers/templates_downloader'

require 'project_builder/models/project_info'

require 'project_builder/tasks/generators/project_generator'
require 'project_builder/tasks/generators/gitignore_generator'
require 'project_builder/tasks/generators/gemfile_generator'
require 'project_builder/tasks/generators/podfile_generator'
require 'project_builder/tasks/generators/fastfile_generator'
require 'project_builder/tasks/generators/rambafile_generator'

require 'project_builder/tasks/git_init'

module ProjectBuilder
	class CLI < Thor

		desc 'gen', 'generate project'
		method_option :project_name, :type => :string, :required => true, :desc => 'e.g. MyProject'
		method_option :organization_name, :type => :string, :required => true, :desc => 'e.g. MyCompany'
		method_option :bundle_id, :type => :string, :required => true, :desc => 'e.g. my.project.bundle.id'
		method_option :templates_repository, :type => :string, :default => 'https://github.com/Beniamiiin/ProjectBuilderCatalog.git', :required => true, :desc => 'e.g. https://github.com/Beniamiiin/ProjectBuilderCatalog.git'
		def gen
			# Check if Xcodegen is installed
			unless ProjectBuilder::DependencyCheker.is_xcodegen_installed
				puts "Xcodegen didn't find".colorize(:red)
				puts "Installing xcodegen".colorize(:yellow)
				ProjectBuilder::DepenencyInstaller.install_xcodegen
			end

			# Downloading templates
			templates_downloader = ProjectBuilder::TemplatesDownloader.instance
			templates_downloader.setup(options[:templates_repository])
			templates_downloader.download

			# Creating ProjectInfo model
			project_info = ProjectBuilder::ProjectInfo.new
			project_info.name = options[:project_name]
			project_info.organization_name = options[:organization_name]
			project_info.bundle_id = options[:bundle_id]

			# Creating project root directory
			FileUtils.mkdir_p project_info.name

			# Generating project files
			generate_project(project_info)
			generate_gemfile(project_info)
			generate_podfile(project_info)
			generate_rambafile(project_info)
			generate_fastfile(project_info)
			generate_gitignore(project_info)
			
			# Get init
			git_init(project_info)

			# Deleting templates
			templates_downloader.delete
		end

		private
		
		def generate_project(project_info)
			generator = ProjectBuilder::ProjectGenerator.new
			generator.generate(project_info)
		end

		def generate_gitignore(project_info)
			generator = ProjectBuilder::GitignoreGenerator.new
			generator.generate(project_info)
		end

		def generate_gemfile(project_info)
			generator = ProjectBuilder::GemfileGenerator.new
			generator.generate(project_info)
		end

		def generate_podfile(project_info)
			generator = ProjectBuilder::PodfileGenerator.new
			generator.generate(project_info)
		end

		def generate_fastfile(project_info)
			generator = ProjectBuilder::FastfileGenerator.new
			generator.generate(project_info)
		end

		def generate_rambafile(project_info)
			generator = ProjectBuilder::RambafileGenerator.new
			generator.generate(project_info)
		end

		def git_init(project_info)
			git_init = ProjectBuilder::GitInit.new
			git_init.execute(project_info)
		end

	end
end
