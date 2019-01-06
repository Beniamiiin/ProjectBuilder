module ProjectBuilder
	class DependencyCheker

		def self.is_xcodegen_installed
			`brew ls --versions xcodegen`.empty? == false
		end

	end
end