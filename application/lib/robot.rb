class Robot
  attr_accessor :x
  attr_accessor :y
  attr_accessor :orientation

  ORIENTATIONS = %w{N E S W}

  def initialize(x = 0, y = 0, orientation = 'N')
    @x = x
    @y = y
    @orientation = orientation
  end

  def rotate_left
    current_index = ORIENTATIONS.index(@orientation)
    @orientation = ORIENTATIONS[current_index - 1]
  end

  def rotate_right
    current_index = ORIENTATIONS.index(@orientation)
    new_index = (current_index + 1) % ORIENTATIONS.length

    @orientation = ORIENTATIONS[new_index]
  end

  def move_forward(distance = 1)
    case @orientation
    when 'N'
      @y += distance
    when 'E'
      @x += distance
    when 'S'
      @y -= distance
    when 'W'
      @x -= distance
    end
  end

  def to_hash
    {
      x: @x,
      y: @y,
      orientation: @orientation
    }
  end

  def to_s
    "#{@x},#{@y},#{@orientation}"
  end
end