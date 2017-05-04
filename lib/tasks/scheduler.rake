#  Quandl::Database.get('WIKI').datasets(options: {date: '2017-05-03'}).first.close


desc "This task is called by the Heroku scheduler add-on"

Quandl::ApiConfig.api_key = 'xNSxrMU_zRKHVD-7TKxJ'
Quandl::ApiConfig.api_version = '2015-04-09'

require 'open-uri'
require 'zip'
require 'csv'

task :populate_stocks => :environment do
	changed = 0
	added = 0
	puts "Populating stocks now..."
	url = "https://s3.amazonaws.com/quandl-static-content/Ticker+CSV%27s/secwiki_tickers.csv"
	CSV.new(open(url), :headers => :first_row).each do |line|
		sym = line[0]
		name = line[1]
		sector = line[2]
		industry = line[3]
		if !Stock.exists?(stock_symbol: sym) then
			puts "Adding: " + name.to_s
			Stock.create(stock_symbol: sym, stock_name: name)
			added = added + 1
		else
			puts "Updating: " + name.to_s
			Stock.find_by(stock_symbol: sym).update(sector: sector, industry: industry)
			changed = changed + 1
		end
	end
	puts "Changed: " + changed.to_s
	puts "Added: " + added.to_s
end


task :update_stocks => :environment do
  puts "Updating stocks..."
  date = Date.yesterday.to_date
  url = "https://www.quandl.com/api/v3/datatables/WIKI/PRICES.csv?date=" + date.to_s + "&api_key=xNSxrMU_zRKHVD-7TKxJ"
  # Method to update stocks
  CSV.new(open(url), :headers => :first_row).each do |line|
  	sym = line[0]
  	if stock = Stock.find_by(stock_symbol: sym) then
  		if stock.updated_at.to_date != date then
  			stock.update(stock_price: line[12])
  		end
  	else

  	end

  	

  end

  puts "done."
end

