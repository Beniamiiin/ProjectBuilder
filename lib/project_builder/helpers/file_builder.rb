require 'liquid'

module ProjectBuilder
	class FileBuilder

		def build_file(name, template_path, properties = {})
			file_source = IO.read(template_path)
			content = Liquid::Template.parse(file_source).render(properties)
			File.open(name, 'w+') { |f| f.write(content) }
		end

	end
end