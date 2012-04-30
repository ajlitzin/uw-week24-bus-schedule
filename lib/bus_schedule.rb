class Stop
  attr_accessor :stop_number, :intersection, :departure_time, :routes_serving_stop, :notes
  
  def shelter=(shelter)
    @shelter = shelter
  end
  def shelter?
    if shelter.is_a(TrueClass)
	  @shelter = shelter
	elsif shelter.is_a(FalseClass)
	  @shelter = shelter
	else
	  @shelter = false
	end
  end
end

class Route
require 'pp'

  def initialize(route_name)
    @route_name = route_name
  end
  attr_reader :stops

  def stop(intersection, time, stop_number, routes_serving_stop = [], shelter = false, other = {})
    # create and define a stop object
	# a Route obj collects stop objects
	# some larger collection collects mutiple Route objectes
	# e.g. Route.new
	# Route[<route_number>].<stop_number>.property
	# this wont really work unless i monkey patch Fixnum
	# how else can 
	this_stop = Stop.new
	this_stop.stop_number = stop_number
	this_stop.intersection = intersection
	this_stop.departure_time = time
	this_stop.routes_serving_stop = routes_serving_stop
	this_stop.shelter = shelter
	pp this_stop
	#so now i have a stop object, but it disappears as soon as the next
	# stop def comes through the block loop
	# how do i persist it?
    
  end
  
  
  def self.schedule(route_name,&schedule_block)
     route = self.new
	 route.instance_eval(&schedule_block) if schedule_block
	 #puts route
	 #pp route
	 route
	 
  end
  
  
  
end


Route.schedule "4" do
  # origin
  stop "50th Ave & Funky St", "12:00", 1, %w[5,51], false, "coolville"
  stop "40th Ave & Funky St", "12:10", 2
  stop "30th Ave & Funky St", "12:20", 3
  stop "20th Ave & Funky St", "12:30", 4
  stop "10th Ave & Funky St", "12:40", 5
  #terminus
  stop "1st Ave & Funky St", "12:50", 6, "funkytown"
end