require 'sequel'

database = Sequel.sqlite('db/robot_world.sqlite')
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
