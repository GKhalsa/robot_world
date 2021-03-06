class RobotWorldApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  get '/robots/data' do
    @avg_age = robot_world.average_age
    @hired_by_year = robot_world.hired_by_year
    @robots_per_dept = robot_world.robots_per_dept
    @robots_per_city = robot_world.robots_per_city
    @robots_per_state = robot_world.robots_per_state
    erb :data
  end

  post '/robots' do
    robot_world.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_world.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_world.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_world.update(id.to_i, params[:robot])
    redirect '/robots'
  end

  delete '/robots/:id' do |id|
    robot_world.delete(id.to_i)
    redirect '/robots'
  end

  post '/robots/search' do
    robots = robot_world.find_by_name(params[:robot][:name])
     if robots.empty?
       erb :result
     else
       @found_robos = robots
       erb :search_results
     end
  end


  def robot_world
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite('db/robot_world_test.sqlite')
    else
      database = Sequel.sqlite('db/robot_world.sqlite')
    end
    @robot_world ||= RobotWorld.new(database)
  end

end
