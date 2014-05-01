class LittleBlackBook
	attr_reader :who
	attr_accessor :place, :dates, :places, :who, :first_date
	def initialize(my_date={})
		style_1
		open = gets.chomp
		if open == "New" 
			style_2
			@who = my_date[:who] || gets.chomp
			style_3
			@place = my_date[:place] || gets.chomp
			@when = my_date[:when] || Time.now.strftime("%m/%d/%Y")
			style_4
			@new_when = my_date[:@new_when] || gets.chomp
			new_location = Location.new(@place, @who, @when, @new_when)
		elsif open == "Search"
			style_5
			@first_date = my_date[:@first_date] || gets.chomp
			new_WhichDate = WhichDate.new(@first_date)
		end
	end

	def style_1
		puts "======================================"
		puts "   Welcome To My Little Black Book"
		puts "          New or Search?"
		puts "======================================"
	end

	def style_2
		puts "--------------------------------------"
		puts "  Who Are You Going On A Date With?"
		puts "--------------------------------------"
	end

	def style_3
		puts "--------------------------------------"
		puts "        Where Are You Going?"
		puts "--------------------------------------"
	end

	def style_4
		puts "--------------------------------------"
		puts "         When was the date?"
		puts  "         Default's today!"
		puts "--------------------------------------"
	end

	def style_5
		puts "--------------------------------------"
		puts "  Which date would you like to view?"
		puts "       Default is First Date!"
		puts "      Total, All, Random, Last"
		puts "--------------------------------------"
	end


end

class Location
require 'csv'
	attr_accessor :places
	def initialize(place, who, today, checking)
		@places = place
		@places = []
		@places << "#{who} "
		@places << "#{place} "
			if checking == ""
				@places << "#{today} "
			else
				@places << "#{checking} "
			end
		add
		WhichDate.new("Last")
	end

	def add
		CSV.open("lbb_places.csv", "ab") do |csv|
			csv << [@places.join]
		end
	end
end
# 
class WhichDate
	def initialize(index)
		@index = index
		@all_dates = []
		# final_index = @index.to_i
		CSV.foreach("lbb_places.csv") do |row|
		  @all_dates << row
		end
		print_all_dates
	end

	def print_all_dates
		all_dates_length = @all_dates.length
		all_dates_length = all_dates_length - 1
		if @index == ""
		 puts @all_dates[0]
		elsif @index == "All"
		 puts @all_dates
		elsif @index == "Random"
		 puts @all_dates.sample
		elsif @index == "Total"
		 puts @all_dates.length
		elsif @index == "Last"
		 p @all_dates[all_dates_length]
		else
		 puts @all_dates[@index.to_i]
		end
	end


end

my_book = LittleBlackBook.new()
