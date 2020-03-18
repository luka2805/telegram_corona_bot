require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'scraper'


class Cases
	def self.countries_stats
		countries = Corona::Scraper.new.parse_to_json
		hash_countries = countries.reduce({}, :merge!)
		return hash_countries
	end

end