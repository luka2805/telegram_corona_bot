require 'telegram/bot'
require_relative 'CoronaStats'

token = ARGV[0]
puts "Token is: " + token.to_s

stats = Corona::Stats.new
time = Time.now

contaminated_countries = stats.get_countries

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
  	if Time.now - time > 1800
  		stats = Corona::Stats.new
  	end
  	if not message.text.nil? and message.text[0] = "/"
	  	if contaminated_countries.include? message.text.sub("/", "").capitalize
	  		puts "Country exists!"
	  		country_name = message.text.sub("/", "").capitalize
	  		country_summary = stats.total_country(country_name)
	  		bot.api.send_message(chat_id: message.chat.id, text: country_summary)
	  	else
	  		puts "Country not found!"
	  	end
	  end
  end
end