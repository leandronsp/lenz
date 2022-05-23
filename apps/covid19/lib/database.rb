require 'pg'

class Database
  def initialize
    @connection =
      PG.connect(
        host: 'covid19-pg',
        user: 'covid19',
        password: 'covid19',
        dbname: 'covid19'
      )
  end

  def execute(sql)
    @connection.exec(sql)
  end
end
