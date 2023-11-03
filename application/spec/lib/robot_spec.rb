require 'spec_helper'
require 'robot'

RSpec.describe Robot do
  let (:robot) { Robot.new(0, 0, 'N') }

  describe('initialization') do
    it('should have an x coordinate') do
      expect(robot.x).to eq(0)
    end

    it('should have an y coordinate') do
      expect(robot.y).to eq(0)
    end

    it('should have an orientation') do
      expect(robot.orientation).to eq('N')
    end
  end

  describe('move_forward') do
    it('should move forward 5 spaces from North') do
      robot.move_forward(5);

      expect(robot.y).to eq(5)
      expect(robot.x).to eq(0)
    end

    it('should move forward 5 spaces from East') do
      robot.rotate_right
      robot.move_forward(5)

      expect(robot.y).to eq(0)
      expect(robot.x).to eq(5)
    end

    it('should move forward 5 spaces from South') do
      robot.rotate_right
      robot.rotate_right
      robot.move_forward(5)

      expect(robot.y).to eq(-5)
      expect(robot.x).to eq(0)
    end

    it('should move forward 5 spaces from West') do
      robot.rotate_left
      robot.move_forward(5)

      expect(robot.y).to eq(0)
      expect(robot.x).to eq(-5)
    end

    it('should move forward 5 spaces from West, rotate left once and move 3 spaces south') do
      robot.rotate_left
      robot.move_forward(5)

      robot.rotate_left
      robot.move_forward(3)

      expect(robot.y).to eq(-3)
      expect(robot.x).to eq(-5)
    end

    it('should move forward 5 spaces from West, rotate left once and move 3 spaces south') do
      robot.rotate_left
      robot.move_forward(5)

      robot.rotate_left
      robot.move_forward(3)

      robot.rotate_left
      robot.move_forward(3)

      expect(robot.y).to eq(-3)
      expect(robot.x).to eq(-2)
    end
  end

  describe('rotate_left') do
    it('should rotate left once and be facing west') do
      robot.rotate_left

      expect(robot.orientation).to eq('W')
    end

    it('should rotate left twice and be facing south') do
      robot.rotate_left
      robot.rotate_left

      expect(robot.orientation).to eq('S')
    end

    it('should rotate left three times and be facing east') do
      robot.rotate_left
      robot.rotate_left
      robot.rotate_left

      expect(robot.orientation).to eq('E')
    end

    it('should rotate left four times and be facing north') do
      robot.rotate_left
      robot.rotate_left
      robot.rotate_left
      robot.rotate_left

      expect(robot.orientation).to eq('N')
    end

    it('should rotate left five times and be facing west') do
      robot.rotate_left
      robot.rotate_left
      robot.rotate_left
      robot.rotate_left
      robot.rotate_left

      expect(robot.orientation).to eq('W')
    end
  end

  describe('rotate_right') do
    it('should rotate right once and be facing east') do
      robot.rotate_right

      expect(robot.orientation).to eq('E')
    end

    it('should rotate right twice and be facing south') do
      robot.rotate_right
      robot.rotate_right

      expect(robot.orientation).to eq('S')
    end

    it('should rotate right three times and be facing west') do
      robot.rotate_right
      robot.rotate_right
      robot.rotate_right

      expect(robot.orientation).to eq('W')
    end

    it('should rotate right four times and be facing north') do
      robot.rotate_right
      robot.rotate_right
      robot.rotate_right
      robot.rotate_right

      expect(robot.orientation).to eq('N')
    end

    it('should rotate right five times and be facing east') do
      robot.rotate_right
      robot.rotate_right
      robot.rotate_right
      robot.rotate_right
      robot.rotate_right

      expect(robot.orientation).to eq('E')
    end
  end

  describe('to_s') do
    it('should return a string representation of the robot') do
      expect(robot.to_s).to eq('0,0,N')
    end
  end

  describe('to_hash') do
    it('should return a string representation of the robot') do
      expect(robot.to_hash).to eq({
        x: 0,
        y: 0,
        orientation: 'N'
      })
    end
  end
end