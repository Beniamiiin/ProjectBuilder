require 'fileutils'

require 'project_builder/models/project_info'

module ProjectBuilder
	class ProjectBuilderHelper

		def self.prepare(project_info)
			FileUtils.mkdir_p project_info.name
		end

	end
end