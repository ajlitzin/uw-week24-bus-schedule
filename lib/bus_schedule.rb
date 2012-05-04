class Stop
  attr_reader :stop_number, :intersection, :departure_time, :routes_serving_stop, :notes
  
  def initialize(stop_number,departure_time, routes_serving_stop, shelter = false, notes = [])
    @stop_number = stop_number
	@departure_time = departure_time
	@routes_serving_stop = routes_serving_stop
	@notes = notes
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

class BusRoutes
require 'pp'
# BusRoutes collects mutiple Route objectes
# a Route obj collects Stop objects
  def self.route(name,&block)
    @routes ||= []
	route = Route.new(name)
	route.instance_eval(&block)
	pp route
	@routes << route
	route
	
  end
end

class Route
require 'pp'
attr_reader :name
  def initialize(route_name)
    @route_name = route_name
  end
  attr_reader :stops

  def stop(intersection, departure_time, stop_number, routes_serving_stop = [], shelter = false, other = {})	
	@stops ||= {}
	#(stop_name,departure_time, routes_serving_stop, shelter = false, notes = [])
	@stops[intersection] = Stop.new stop_number, departure_time, routes_serving_stop, shelter, other
	#pp @stops 
  end
    
end


fifteen_schedule = BusRoutes.route "15" do
  # origin
  stop "50th Ave & Funky St", "12:00", 1, %w[5,51], true, "coolville"
  stop "40th Ave & Funky St", "12:10", 2
  stop "30th Ave & Funky St", "12:20", 3
  stop "20th Ave & Funky St", "12:30", 4
  stop "10th Ave & Funky St", "12:40", 5
  #terminus
  stop "1st Ave & Funky St", "12:50", 6, "funkytown"
end
pp fifteen_schedule