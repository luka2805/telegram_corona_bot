require_relative 'Cases'

module Corona
	class Stats
		def initialize
			@countries_stats = Cases.countries_stats
		end


		def total_country(country)
			ret_string = []
			if country == 'usa'
				country = 'USA'
			end

			if country == 'uk'
				country = 'UK'
			end
			@countries_stats[country].each do |key, value|
				if country == 'USA'
					ret_string << "#{key}: #{value}\n"
				elsif country == 'UK'
					ret_string << "#{key}: #{value}\n"
				else
					ret_string << "#{key.capitalize}: #{value}\n"
				end
			end
			dead_to_infected_ratio = @countries_stats[country]["Total Deaths"].sub(",", "").to_f / @countries_stats[country]["Total Cases"].sub(",", "").to_f
			ret_string << "Dead to infected ratio: #{(dead_to_infected_ratio * 100).round(2)}%\n"

			return ret_string.join
		end

		def get_countries
			@countries_stats.keys
		end
	end
end