require 'fileutils'

require 'project_builder/models/project_info'

module ProjectBuilder
	class ProjectBuilderHelper

		def self.prepare(project_info)
			`rm -rf #{project_info.name}`
			FileUtils.mkdir_p project_info.name
		end

	end
end