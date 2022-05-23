require 'csv'
require 'byebug'
require './lib/database'

database = Database.new

# https://covid.ourworldindata.org/data/owid-covid-data.csv
data = CSV.read('./data/covid-data-2022-05-23.csv')

columns = data.shift

database.execute <<-SQL
  DROP TABLE IF EXISTS covid19
SQL

sql_columns =
  columns
  .map { |column| "#{column} VARCHAR(255)" }
  .join(', ')

database.execute <<-SQL
  CREATE TABLE IF NOT EXISTS covid19 (
    id SERIAL, #{sql_columns}
  )
SQL

values = data.map do |row|
  cells = row.map { |cell| cell ? "'#{cell.gsub("'", "\"")}'" : "''" }
  "(#{cells.join(', ')})"
end

pages = values.size / 1000
puts "Pages: #{pages}"

values.each_slice(1000) do |slice|
  pages -= 1
  sql_values = slice.join(', ')

  database.execute <<-SQL
  INSERT INTO covid19
    (#{columns.join(', ')})
    VALUES
    #{sql_values}
  SQL

  puts pages
end
