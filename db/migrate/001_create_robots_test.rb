require 'sequel'

database = Sequel.sqlite('db/robot_world_test.sqlite')
database.create_table :robots do
  primary_key :id
  String      :name
  String      :city
  String      :state
  String      :birthdate
  String      :date_hired
  String      :department
end
#change file name to create robots
