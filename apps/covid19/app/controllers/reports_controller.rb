# frozen_string_literal: true

require_relative '../../lib/database'

module Covid19
  class ReportsController < Chespirito::Controller
    def index
      db = Database.new

      sql = <<-SQL
select
date,
location,
iso_code,
new_cases_smoothed,
new_cases_smoothed_per_million
from covid19
where continent <> ''
and (new_cases_smoothed_per_million <> '' or new_cases_smoothed_per_million <> null)
and iso_code = '#{request.params['iso_code']}'
group by date, location, iso_code, new_cases_smoothed, new_cases_smoothed_per_million
order by date desc;
      SQL

      result = db.execute(sql)

      json = result.entries.to_json

      response.status = 200
      response.headers['Content-Type'] = 'application/json'
      response.body = json
    end
  end
end
