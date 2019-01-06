require 'singleton'
require 'colorize'

module ProjectBuilder
	class TemplatesDownloader

		include Singleton

		def setup(respository)
			@respository = respository
			@catalog_name = File.basename(respository, '.git')
			@templates_path = "#{@catalog_name}/Templates"
  		end

		def download
			puts 'Downloading templates'.colorize(:yellow)
			script = "git clone #{@respository}"
			puts script.colorize(:green)
			`#{script}`
		end

		def delete
			`rm -rf #{@catalog_name}`
		end
		
		def project_files_directory_path
			"#{@templates_path}/Project"
		end

		def project_file
			"#{@templates_path}/Project/project.yml.liquid"
		end		

		def gemfile
			"#{@templates_path}/Gemfile.liquid"
		end

		def podfile
			"#{@templates_path}/Podfile.liquid"
		end

		def rambafile
			"#{@templates_path}/Rambafile.liquid"
		end

		def fastlane_files
			{
				'fastfile' => "#{@templates_path}/fastlane/Fastfile.liquid",
				'appfile' => "#{@templates_path}/fastlane/Appfile.liquid"
			}
		end

	end
end