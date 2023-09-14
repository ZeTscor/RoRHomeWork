require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

# Create necessary objects and initialize variables
stations = []
trains = []
routes = []

def print_stations(stations)
  puts "Available stations:"
  stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
end

def print_trains(trains)
  puts "Trains at the station:"
  trains.each_with_index { |train, index| puts "#{index + 1}. Train #{train.number}" }
end

def print_routes(routes)
  puts "Available routes:"
  routes.each_with_index do |route, index|
    puts "#{index + 1}. From #{route.stations.first.name} to #{route.stations.last.name}"
  end
end

loop do
  puts "=== Train System Menu ==="
  puts "1. Create a station"
  puts "2. Create a train"
  puts "3. Create a route"
  puts "4. Add or remove stations from a route"
  puts "5. Assign a route to a train"
  puts "6. Add carriages to a train"
  puts "7. Remove carriages from a train"
  puts "8. Move a train forward along the route"
  puts "9. Move a train backward along the route"
  puts "10. View list of stations and trains"
  puts "0. Exit"

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Enter the name of the station:"
    station_name = gets.chomp
    station = Station.new(station_name)
    stations << station
    puts "Station #{station.name} has been created."
  when 2
    puts "Enter the train number:"
    train_number = gets.chomp
    puts "Select the train type (1 - passenger, 2 - cargo):"
    train_type = gets.chomp.to_i

    case train_type
    when 1
      train = PassengerTrain.new(train_number)
      trains << train
      puts "Passenger train #{train.number} has been created."
    when 2
      train = CargoTrain.new(train_number)
      trains << train
      puts "Cargo train #{train.number} has been created."
    else
      puts "Invalid train type."
    end
  when 3
    if stations.size < 2
      puts "Not enough stations to create a route. Please create at least 2 stations first."
      next
    end

    print_stations(stations)

    puts "Enter the number of the start station:"
    start_station_index = gets.chomp.to_i - 1
    puts "Enter the number of the end station:"
    end_station_index = gets.chomp.to_i - 1

    start_station = stations[start_station_index]
    end_station = stations[end_station_index]

    route = Route.new(start_station, end_station)
    routes << route
    puts "Route from #{start_station.name} to #{end_station.name} has been created."
  when 4
    if routes.empty?
      puts "No routes available. Please create a route first."
      next
    end

    puts "Select a route to manage:"

    routes.each_with_index { |route, index| puts "#{index + 1}. From #{route.stations.first.name} to #{route.stations.last.name}" }

    route_index = gets.chomp.to_i - 1
    selected_route = routes[route_index]

    loop do
      puts "=== Route Management Menu ==="
      puts "1. Add a station"
      puts "2. Remove a station"
      puts "0. Go back"

      route_choice = gets.chomp.to_i

      case route_choice
      when 1
        print_stations(stations)

        puts "Enter the number of the station to add:"
        station_index = gets.chomp.to_i - 1
        station = stations[station_index]

        selected_route.add_station(station)
        puts "Station #{station.name} has been added to the route."
      when 2
        puts "Select a station to remove from the route:"

        selected_route.stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }

        station_index = gets.chomp.to_i - 1
        station = selected_route.stations[station_index]

        selected_route.remove_station(station)
        puts "Station #{station.name} has been removed from the route."
      when 0
        break
      else
        puts "Invalid choice."
      end
    end
  when 5
    if trains.empty? || routes.empty?
      puts "No trains or routes available. Please create at least one train and route first."
      next
    end
    print_trains(trains)
    puts "Select a train to assign a route:"
    train_index = gets.chomp.to_i - 1
    train = trains[train_index]

    print_routes(routes)
    puts "Select a route to assign to the train:"
    route_index = gets.chomp.to_i - 1
    route = routes[route_index]

    train.assign_route(route)
    puts "Route has been assigned to Train #{train.number}."

  when 6
    if trains.empty?
      puts "No trains available. Please create a train first."
      next
    end

    print_trains(trains)
    puts "Select a train to add carriages to:"
    train_index = gets.chomp.to_i - 1
    train = trains[train_index]

    puts "Enter the number of carriages to add:"
    carriage_count = gets.chomp.to_i

    carriage_type = train.type == :passenger ? PassengerCarriage : CargoCarriage

    carriage_count.times do
      carriage = carriage_type.new
      train.attach_carriage(carriage)
    end

    puts "#{carriage_count} carriage(s) have been added to Train #{train.number}."

  when 7
    if trains.empty?
      puts "No trains available. Please create a train first."
      next
    end

    print_trains(trains)
    puts "Select a train to remove carriages from:"
    train_index = gets.chomp.to_i - 1
    train = trains[train_index]

    puts "Enter the number of carriages to remove:"
    carriage_count = gets.chomp.to_i

    carriage_count.times do
      carriage = train.carriages.last
      train.detach_carriage(carriage)
    end

    puts "#{carriage_count} carriage(s) have been removed from Train #{train.number}."

  when 8
    if trains.empty?
      puts "No trains available. Please create a train first."
      next
    end

    print_trains(trains)
    puts "Select a train to move forward:"
    train_index = gets.chomp.to_i - 1
    train = trains[train_index]

    train.move_forward

  when 9
    if trains.empty?
      puts "No trains available. Please create a train first."
      next
    end

    print_trains(trains)
    puts "Select a train to move backward:"
    train_index = gets.chomp.to_i - 1
    train = trains[train_index]

    train.move_backward

  when 10
    puts "=== List of Stations and Trains ==="
    stations.each_with_index do |station, index|
      puts "#{index + 1}. Station: #{station.name}"
      print_trains(station.trains)
      puts "----------------------"
    end
  when 0
    break
  else
    puts "Invalid choice."
  end
end
