namespace :ubike do
  desc "TODO"
  task seed: :environment do
  	url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"
 
  	json_string = RestClient.get(url)
		data = JSON.parse( json_string )

		data["result"]["results"].each do |u|
			existing_ubike = UbikeSt.find_by_iid(u["iid"])
			if existing_ubike
				
				existing_ubike.update(
					:station => u["sna"],
					:ubike_count => u["sbi"],
					:address => u["aren"]
				)
				puts "Update #{existing_ubike.station}"
			else
				puts "Create success"
				UbikeSt.create(
					:iid => u["iid"],
					:station => u["sna"],
					:ubike_count => u["sbi"],
					:address => u["aren"]
				)
			end
		end
		puts "#{UbikeSt.all.count}"
  end

end
