require 'influxdb'

  username = 'root'
  password = 'root'
  database = 'test'
  database2 = 'test2'
  name     = 'dashboard'
  name2    = 'dashboard2'
# http://52.62.46.112:8086
  influxdb = InfluxDB::Client.new host: "52.62.46.112", username: username, password: password, database: database
  influxdb2 = InfluxDB::Client.new host: "52.62.46.112", username: username, password: password, database: database2

# Enumerator that emits a sine wave
  Value = (0..10000000).to_a.map {|i| Math.send(:sin, i / 10.0) * 10 }.each

def data_points
  [
      {
          series: "score",
          values: { value: rand(200) }
      },
      {
          series: "searches",
          values: { value: rand(200) }
      }
  ]
  end

def write_data_points
  client.write_points(data_points)
end


  count = 0

  loop do
    data = {
        values: { value: Value.next },
        tags:   { wave: 'sine' }, # tags are optional
      }
    influxdb.write_point(name, data)

    influxdb2.write_points(data_points)

    sleep 5
    count = count+1
    puts "inserting datapoint #{count}"
  end

