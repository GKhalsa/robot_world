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
    binding.pry
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
    robot = robot_world.find_by_name(params[:robot][:name])
     if robot.nil?
       erb :result
     else
       id = robot.id
       redirect "robots/#{id}"
     end
     #inside robotworld change the find to find all and show the results of that array like in index but with only those findings. Dont forget to do .count <= .count so that you cant search harry with rrr
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
