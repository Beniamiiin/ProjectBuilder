module ProjectBuilder
	class ProjectInfo
		attr_accessor :name, :organization_name, :bundle_id

		def hash_representation
			{
				'project_info' => {
					'name' => name,
					'company' => organization_name,
					'bundle_id' => bundle_id,
				}
			}
		end
	end
end