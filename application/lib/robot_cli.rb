require_relative './robot'

class RobotCli
  attr_accessor :robot, :robots, :current_robot

  VALID_COMMANDS = %w{MOVE LEFT RIGHT EXIT ADD SWITCH}

  def initialize(io = $stdin)
    @io = io
    add_robot
  end

  def execute
    while true
      puts "Enter the command: "
      command = @io.gets.chomp

      validate_command(command)

      case command
      when 'ADD'
        add_robot
      when 'SWITCH'
        handle_switch_command
      when 'EXIT'
        break
      else
        # Move/rotate the robot
        move_robot(command)
        puts print_position
      end
    end
  end

  def add_robot
    @robots ||= []
    @robots << Robot.new
    switch_robot(@robots.length)
  end

  def add_robots(count)
    count.times do
      add_robot
    end
  end

  def handle_switch_command
    puts "Enter the index of the robot: "

    index = @io.gets.chomp.to_i

    switch_robot(index)
  end


  def switch_robot(index)
    @robot = @robots[index -1]
    @current_robot = index

    puts "Now using robot #{@current_robot}"
  end

  def validate_command(command)
    VALID_COMMANDS.include?(command)
  end

  def move_robot(command)
    case command
    when 'MOVE'
      @robot.move_forward
    when /MOVE\s(\d+)/
      @robot.move_forward($1.to_i)
    when 'LEFT'
      @robot.rotate_left
    when 'RIGHT'
      @robot.rotate_right
    else
      raise "Invalid command #{command}"
    end
  end

  def print_position
    @robot.to_s
  end

  def get_position
    @robot.to_hash
  end
end


