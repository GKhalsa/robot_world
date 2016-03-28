require 'sequel'

["robot_world", "robot_world_test"].each do |path|
  database = Sequel.sqlite("db/#{path}.sqlite")
  database.create_table :robots do
    primary_key :id
    String      :name
    String      :city
    String      :state
    String      :birthdate
    String      :date_hired
    String      :department
    String      :photo
  end
end
