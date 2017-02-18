require_relative "robot_class"
require "test/unit"
 
class TestRobot < Test::Unit::TestCase
 
  def setup
    @robot = Robot.new(5,5)
  end
 
  def test_place
    @robot.place(['', 0, 0, 'north'])
    @robot.move
    assert_equal("0,1,NORTH", @robot.report )
  end
 
  def test_place1
    @robot.place(['', 0, 0, 'north'])
    @robot.change_direction -90 #left
    assert_equal("0,0,WEST", @robot.report )
  end
 
  def test_place2
    @robot.place(['', 1, 2, 'east'])
    @robot.move
    @robot.move
    @robot.change_direction -90 #left
    @robot.move
    assert_equal("3,3,NORTH", @robot.report )
  end
 
end