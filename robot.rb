#!/usr/bin/env ruby
require_relative 'robot_class'


# Robot.new(5, 5).read_input                    # to read commands from STDIN
Robot.new(5, 5).read_input "input.txt"      # to read from file
