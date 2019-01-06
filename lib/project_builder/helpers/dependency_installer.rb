module ProjectBuilder
	class DependencyInstaller

		def self.install_xcodegen
			`brew install xcodegen`
		end

	end
end