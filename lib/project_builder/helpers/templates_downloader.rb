module ProjectBuilder
	class TemplatesDownloader

		TEMPLATES_PATH = 'BenToolKit/Templates'.freeze

		def download
			`git clone https://github.com/Beniamiiin/BenToolKit.git`
		end

		def delete
			`rm -rf BenToolKit`
		end
		
		def project_files_directory_path
			"#{TEMPLATES_PATH}/Project"
		end

		def project_file
			"#{TEMPLATES_PATH}/Project/project.yml.liquid"
		end		

		def gemfile
			"#{TEMPLATES_PATH}/Gemfile.liquid"
		end

		def podfile
			"#{TEMPLATES_PATH}/Podfile.liquid"
		end

		def rambafile
			"#{TEMPLATES_PATH}/Rambafile.liquid"
		end

		def fastlane_files
			{
				'fastfile' => "#{TEMPLATES_PATH}/fastlane/Fastfile.liquid",
				'appfile' => "#{TEMPLATES_PATH}/fastlane/Appfile.liquid"
			}
		end

	end
end