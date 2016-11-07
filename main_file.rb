# Game Tik-tak-toe

# Player models
class Player
	attr_accessor :name, :mark

	def initialize(name, mark)
		@name = name
		@mark = mark
	end
end


class Desk
		attr_reader :full_desk

	def initialize
		@full_desk = Array.new(9,"-")
	end

	def change_desk_cell(value, mark)
			@full_desk[value.to_i-1] = mark
	end	

	def show_desk
		puts "\n#{@full_desk[0]}|#{@full_desk[1]}|#{@full_desk[2]}\n"\
		 "#{@full_desk[3]}|#{@full_desk[4]}|#{@full_desk[5]}\n"\
		 "#{@full_desk[6]}|#{@full_desk[7]}|#{@full_desk[8]}\n"
		puts " " 
	end
end



class Game

	def Game.win?(arr, mark)
		result = false
		wining_array = [[0,1,2],[3,4,5,],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		wining_array.each do |inner_arr|
			if inner_arr.all?{|i| arr[i] == mark }
				result = true
			end
		end
		return result			
	end

	def preliminary_actions
		puts "And the game is begin !!!"

		print "Enter first player name: "
		p1_name = gets.chomp
		@p1 = Player.new(p1_name, "X")

		print "Enter second player name: "
		p2_name = gets.chomp	
		@p2 = Player.new(p2_name, "0")

		@desk = Desk.new

		@winner = nil
		@turn = 0
	end

	def valid? val
		if @desk.full_desk[val.to_i-1] == "-" 
			return true
		else
			return false
		end
	end

	def player_turn(player)
		loop do
		print player.name +	" enter your move (between 1 and 9):"
		move = gets.chomp
			if valid?(move)
				@desk.change_desk_cell(move, player.mark)
				break
			else
				puts "Invalid input. Try again"
			end
		end

		if Game.win?(@desk.full_desk,player.mark)
			return true
		else
			return false
		end
	end

	def play
		while @turn < 9

			if @turn.even?
				result = player_turn(@p1)
				if result == true 
					@winner = @p1.name
					break
				end
			else
				result = player_turn(@p2)
				if result == true 
					@winner = @p2.name
					break
				end
			end	
			@turn +=1
			@desk.show_desk
		end

	
		if @winner
				@desk.show_desk
			puts "Winner is #{@winner}"
		else
			puts "Dead heat"
		end
	end

end

game = Game.new
game.preliminary_actions
game.play

