require 'colorize'

require 'project_builder/models/project_info'

module ProjectBuilder
	class GitInit

		def execute(project_info)
			puts "\nInitialize git".colorize(:yellow)
			`cd #{project_info.name} && git init`
		end

	end
end