class Line < ActiveRecord::Base
	has_many :needs
	has_many :rooms
	has_many :services
	has_many :staffs
	has_many :strategies

	def rooms_division(area)
		my_hash = {}
		self.rooms.each {|r| my_hash.store(r.name, area*r.percentage/100)}
		my_hash
	end

	def utility_cost
		a = [800, 520, 220, 250,150, 100, 2.10, 1.45, 1]
		a[self.id-1]
	end

	def office_misc
		a=[6000, 4240, 2800, 1000, 700, 600, 200,200,200]
		a[self.id-1]
	end

	def repair_maintenance
		a=[10000, 4000, 2700, 3200, 2500, 0, 420.50, 290, 0]
		a[self.id-1]
	end	

	def pi_text
		if self.name.start_with?("Fitness")
			{:txt => "PR on TV", :amount => 8000}.to_json
		elsif self.name.start_with?("Education")
			{:txt => "Partnership vs Big4", :amount => 10000}.to_json
		else
			{:txt => "Playroom for kinds", :amount => 5000}.to_json
		end
	end
end
