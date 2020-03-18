First create a bot in Telegram - search for "BotFather"

Create a new bot with command "/newbot"

You'll get access token for Telegram's HTTP API
You can save token as an environment variable:
export TOKEN=<token-value>

use that token to start a bot with ruby script like this:

ruby telebot.rb TOKEN

now when you ping your bot with the country you are looking for it will respond
for example try:
  /italy
  
 output:

Cases: 81
Todaycases: 12
Deaths: 0
Todaydeaths: 0
Recovered: 5
Active: 76
Critical: 0
  

