require 'uri'
require 'net/http'
require 'openssl'
require 'nokogiri'

module Corona
	class Scraper
		def initialize
			@source_data = get_source_html
		end

		def get_source_html
			url = URI("https://www.worldometers.info/coronavirus/")

			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE

			request = Net::HTTP::Get.new(url)
			response = http.request(request)
			return response.read_body
		end

		def get_countries_stats

		end

		def parse_to_json
			parsed_data = Nokogiri::HTML.parse(@source_data)

			table = parsed_data.xpath("//table[@id='main_table_countries_today']")
			table_body = table.xpath("(//tbody)[1]")

			table_rows = table_body.css("tr")

			json_array = []

			table_rows.each do |row|
				country 				= row.css("td")[0].text.strip
				total_cases 		= row.css("td")[1].text.strip
				new_cases 			= row.css("td")[2].text.strip.empty? ? "0" : row.css("td")[2].text.strip
				total_deaths 		= row.css("td")[3].text.strip.empty? ? "0" : row.css("td")[3].text.strip
				new_deaths 			= row.css("td")[4].text.strip.empty? ? "0" : row.css("td")[4].text.strip
				total_recovered = row.css("td")[5].text.strip.empty? ? "0" : row.css("td")[5].text.strip
				active_cases		= row.css("td")[6].text.strip
				serious 				= row.css("td")[7].text.strip.empty? ? "0" : row.css("td")[7].text.strip
				total_per_1m 		= row.css("td")[8].text.strip

				json_array << {country => {
					"Total Cases" => total_cases, 
					"New Cases" => new_cases, 
					"Total Deaths" => total_deaths,
					"New Deaths" => new_deaths,
					"Total Recovered" => total_recovered,
					"Active Cases" => active_cases,
					"Serious" => serious,
					"Total Per 1 Million" => total_per_1m,
					}
				}
			end

			return json_array
		end
	end
end

