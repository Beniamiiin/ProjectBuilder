require 'thor'

require 'project_builder/helpers/dependency_checker'
require 'project_builder/helpers/dependency_installer'
require 'project_builder/helpers/project_builder_helper'
require 'project_builder/helpers/templates_downloader'

require 'project_builder/models/project_info'

require 'project_builder/generators/project_generator'
require 'project_builder/generators/gemfile_generator'
require 'project_builder/generators/podfile_generator'
require 'project_builder/generators/fastfile_generator'
require 'project_builder/generators/rambafile_generator'

module ProjectBuilder
	class CLI < Thor

		desc 'gen', 'generate project'
		method_option :project_name, :type => :string, :required => true, :desc => 'e.g. MyProject'
		method_option :organization_name, :type => :string, :required => true, :desc => 'e.g. MyCompany'
		method_option :bundle_id, :type => :string, :required => true, :desc => 'e.g. my.project.bundle.id'
		def gen
			if ProjectBuilder::DependencyCheker.is_xcodegen_installed
				puts 'Installed'
			else
				puts "Xcodegen didn't find"
				puts "Installing xcodegen"
				ProjectBuilder::DepenencyInstaller.install_xcodegen
			end

			templates_downloader = ProjectBuilder::TemplatesDownloader.new
			templates_downloader.download

			project_info = ProjectBuilder::ProjectInfo.new
			project_info.name = options[:project_name]
			project_info.organization_name = options[:organization_name]
			project_info.bundle_id = options[:bundle_id]

			ProjectBuilder::ProjectBuilderHelper.prepare(project_info)

			generate_project(project_info)
			generate_gemfile(project_info)
			generate_podfile(project_info)
			generate_fastfile(project_info)
			generate_rambafile(project_info)

			templates_downloader.delete
		end

		private
		
		def generate_project(project_info)
			generator = ProjectBuilder::ProjectGenerator.new
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

	end
end
