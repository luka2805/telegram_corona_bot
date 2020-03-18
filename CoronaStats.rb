require_relative 'Cases'

module Corona
	class Stats
		def initialize
			@total_cases = Cases.total_cases
			@countries_stats = Cases.countries_stats
		end

		def total_cases
			@total_cases.each do |key, value|
				puts "#{key}: #{value}"
			end
		end

		def total_country(country)
			ret_string = []
			@countries_stats[country].each do |key, value|
				 ret_string << "#{key.capitalize}: #{value}\n"
			end
			dead_to_infected_ratio = @countries_stats[country]["deaths"] / @countries_stats[country]["cases"].to_f
			ret_string << "Dead to infected ratio: #{(dead_to_infected_ratio * 100).round(2)}%\n"

			return ret_string.join
		end

		def get_countries
			@countries_stats.keys
		end
	end
end