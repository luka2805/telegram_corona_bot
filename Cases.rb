require 'uri'
require 'net/http'
require 'openssl'
require 'json'

$total_cases_url 			= "https://coronavirus-19-api.herokuapp.com/all"
$total_countries_url 	= "https://coronavirus-19-api.herokuapp.com/countries"

class Cases
	def self.get_source(url_string)
		url = URI(url_string)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(url)

		response = http.request(request)
		return JSON.parse(response.read_body)
	end

	def self.total_cases
		get_source($total_cases_url)
	end

	def self.countries_stats
		countries = get_source($total_countries_url)
		hash_countries = countries.map {|record| {record["country"] => record.tap{|x| x.delete("country") }}}
		hash_countries = hash_countries.reduce({}, :merge!)
		return hash_countries
	end


end