# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Field.delete_all
File.open("db_fields.txt", "r") do |infile|
	while (line = infile.gets)
		Field.create(:title => line)
	end
end
File.open("db_abbrs.txt", "r") do |infile|
	f_id = Field.first.id
	while (line = infile.gets)
		Field.find(f_id).update_attributes(:abbr => line)
		f_id = f_id + 1;
	end
end

Course.delete_all
File.open("db_courses.txt", "r") do |infile|
	every_three = 3
	while (line = infile.gets)
		if every_three < 3
			every_three = every_three + 1
		else
			every_three = 1
			f_id = line + Field.first.id - 1
			next
		end
		if every_three == 3
			next
		end

		Course.create(:title => line, :field_id => f_id)

	end
end