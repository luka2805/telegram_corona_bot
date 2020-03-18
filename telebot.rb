require 'telegram/bot'
require_relative 'CoronaStats'

token = ARGV[0]
puts "Token is: " + token.to_s
participating_chats = Hash.new

stats = Corona::Stats.new
time = Time.now # Used for updating stats every 30 minutes

contaminated_countries = stats.get_countries

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

    if participating_chats.has_key? message.chat.id
      participating_chats[message.chat.id] = participating_chats[message.chat.id] + 1
      puts 'Chat: ' + message.chat.id.to_s + ' count: ' + participating_chats[message.chat.id].to_s
    else
      participating_chats[message.chat.id] = 0
    end

  	if Time.now - time > 1800
  		stats = Corona::Stats.new
  	end

    puts message.text
  	if not message.text.nil? and message.text[0] = "/"
      multiple_word_country = message.text.sub("/", "").split(" ").map(&:capitalize).join(" ")
      country_abbreviations = ["USA", "UK"]
	  	if contaminated_countries.include? multiple_word_country
	  		puts message.chat.id.to_s +  " - Country exists!"
	  		country_name = message.text.sub("/", "").capitalize
	  		country_summary = stats.total_country(country_name)
	  		bot.api.send_message(chat_id: message.chat.id, text: country_summary)
			elsif country_abbreviations.include? message.text.sub("/", "").upcase
				puts message.chat.id.to_s +  " - Country exists!"
				country_name = message.text.sub("/", "")
				country_summary = stats.total_country(country_name)
				bot.api.send_message(chat_id: message.chat.id, text: country_summary)
	  	else
	  		puts "Country not found!"
	  	end
	  end
  end
end