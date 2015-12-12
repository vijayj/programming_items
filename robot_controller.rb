=begin
#robot starts at rest
input -  F
output - F1
input - F
output - F2
input - R
output - R1
input - L
output - Z0 #Z- at rest


enum { F, L, R, B}
//validate input
=end


require 'ostruct'

class Controller
  attr_accessor :speed
  attr_accessor :direction

  DIRECTIONS = %w(F B L R)
  AT_REST = 'Z'
  MAX_SPEED = 4
  SPEED_AT_REST = 0

  def initialize
    @speed = SPEED_AT_REST
    @direction =  AT_REST
  end

  def state
    OpenStruct.new(speed: self.speed, direction: self.direction)
  end

  def act(command)
    raise "Invalid Input" unless DIRECTIONS.include?(command)
    move(command)
  end

  private
  def  move(command)
    case command
    when 'F'
      if self.direction == 'F'
        increase_speed
      else
        if perpendicular_direction?(command) || at_rest?
          self.direction = 'F'
          self.speed = 1
        else
          decrease_speed
        end
      end
    end

    when 'B'
      if self.direction == 'B'
        increase_speed
      else
        if perpendicular_direction?(command) || at_rest?
          self.direction = 'B'
          self.speed = 1
        else
          decrease_speed
        end
      end
    end

  end

  def at_rest?
    self.speed == SPEED_AT_REST
  end

  def perpendicular_direction?(direction)
    if (direction == 'F' || direction == 'B')
       self.direction == 'L' || self.direction == 'R'
    else
      self.direction == 'F' || self.direction == 'B'
    end
  end

  def increase_speed
    self.speed = self.speed + 1 unless self.speed == MAX_SPEED
  end

  def decrease_speed
    self.speeed -= 1 unless self.speed == SPEED_AT_REST
  end

end

controller = Controller.new

puts "Enter input"
while(true) do
 command = gets
 command = command.chomp

  controller.act(command)
  puts controller.state
end

