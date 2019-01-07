require 'liquid'

module ProjectBuilder
	class FileBuilder

		def build_file(liquid, outfile_path, properties = {})
			content = Liquid::Template.parse(IO.read(liquid)).render(properties)
			File.open(outfile_path, 'w+') { |f| f.write(content) }
		end

	end
end