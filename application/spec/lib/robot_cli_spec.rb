require 'spec_helper'
require 'robot_cli'

RSpec.describe RobotCli do
  let(:io) {
    $stdin
  }

  let(:robot_cli) {
    RobotCli.new(io)
  }

  describe('initialize') do
    it('should initialize the RobotCli class and set the initial robot') do
      expect(robot_cli.robot).to be_a(Robot)
    end
  end

  describe('execute') do
    it('should receive the command MOVE and move one space forward') do
      allow(io).to receive(:gets).and_return('MOVE', 'EXIT')

      robot_cli.execute

      expect(robot_cli.get_position).to eq({
        x: 0,
        y: 1,
        orientation: 'N'
      })
    end

    it('should receive the command MOVE 5 and move five spaces forward') do
      allow(io).to receive(:gets).and_return('MOVE 5', 'EXIT')

      robot_cli.execute

      expect(robot_cli.get_position).to eq({
        x: 0,
        y: 5,
        orientation: 'N'
      })
    end

    it('should receive the command ADD add add a robot') do
      allow(io).to receive(:gets).and_return('ADD', 'EXIT')

      robot_cli.execute

      expect(robot_cli.robots.length).to eq(2)
      expect(robot_cli.current_robot).to eq(2)
      expect(robot_cli.robot).to be_a(Robot)
    end

    it('should receive the command SWITCH add add a robot') do
      allow(io).to receive(:gets).and_return(
        'ADD',
        'ADD',
        'SWITCH',
        '2',
        'EXIT'
      )

      robot_cli.execute

      expect(robot_cli.robots.length).to eq(3)
      expect(robot_cli.current_robot).to eq(2)
      expect(robot_cli.robot).to be_a(Robot)
    end

    it('should receive an invalid command and throw an error') do
      allow(io).to receive(:gets).and_return('INVALID!', 'EXIT')

      expect { robot_cli.execute }.to raise_error('Invalid command INVALID!')
    end
  end

  describe('move_robot') do
    it('should move the robot forward') do
      robot_cli.move_robot('MOVE')

      expect(robot_cli.get_position).to eq({
        x: 0,
        y: 1,
        orientation: 'N'
      })
    end

    it('should move the robot forward 5 spaces') do
      robot_cli.move_robot('MOVE 5')

      expect(robot_cli.get_position).to eq({
        x: 0,
        y: 5,
        orientation: 'N'
      })
    end

    it('should rotate the robot left') do
      robot_cli.move_robot('LEFT')
      robot_cli.move_robot('MOVE')

      expect(robot_cli.get_position).to eq({
        x: -1,
        y: 0,
        orientation: 'W'
      })
    end

    it('should rotate the robot right') do
      robot_cli.move_robot('RIGHT')

      expect(robot_cli.get_position).to eq({
        x: 0,
        y: 0,
        orientation: 'E'
      })
    end
  end

  describe('print_position') do
    it('should print the position of the robot') do
      expect(robot_cli.print_position).to eq('0,0,N')
    end
  end

  describe('get_position') do
    it('should get the position hash of the robot') do
      expect(robot_cli.get_position).to eq({
        x: 0,
        y: 0,
        orientation: 'N'
      })
    end
  end

  describe('add_robot') do
    it('should add a robot to the robots array') do
      robot_cli.add_robot
      robot_cli.robots.length.should eq(2)
    end
  end

  describe('add_robots') do
    it('should add several robot to the robots array') do
      robot_cli.add_robots(4)
      robot_cli.robots.length.should eq(5)
    end
  end

  describe('switch_robot') do
    it('should change the robot to the selected one') do
      robot_cli.add_robot
      robot_cli.add_robot
      robot_cli.add_robot
      robot_cli.switch_robot(1)
      expect(robot_cli.current_robot).to eq(1)
    end
  end

  describe('validate_command') do
    it('should be true if the command is not in the allowed commands list') do
      expect(robot_cli.validate_command('INVALID!')).to be(false)
    end

    it('should be true if the command is MOVE') do
      expect(robot_cli.validate_command('MOVE')).to be(true)
    end

    it('should be true if the command is ADD') do
      expect(robot_cli.validate_command('ADD')).to be(true)
    end

    it('should be true if the command is SWITCH') do
      expect(robot_cli.validate_command('SWITCH')).to be(true)
    end

    it('should be true if the command is EXIT') do
      expect(robot_cli.validate_command('EXIT')).to be(true)
    end

    it('should be true if the command is LEFT') do
      expect(robot_cli.validate_command('LEFT')).to be(true)
    end

    it('should be true if the command is RIGHT') do
      expect(robot_cli.validate_command('RIGHT')).to be(true)
    end
  end
end