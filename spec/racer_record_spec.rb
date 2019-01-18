require 'rspec'
require 'csv'
require_relative '../lib/model/racer_record'
require_relative '../lib/utils/helpers'

csv_file_path = './db/kart_log.csv'

mock_racer = RACER_RECORDS[-1]

puts "Racer the test is using: {#{mock_racer.piloto},#{mock_racer.codigo}, #{mock_racer.voltas}}"

describe RacerRecord do
  describe '#best_lap' do
    best_lap = []
    mock_racer.voltas.each { |lap_num, lap| best_lap << [lap_num, lap] }
    best_lap.sort! {|x,y| x[1][:tempo] <=> y[1][:tempo]}
    best_lap = best_lap[0]


    it 'should return an array' do
      expect(mock_racer.best_lap).to be_a Array
    end

    it 'should return an array with index 0 lap number and index 1 hash with lap stats' do
      expect(mock_racer.best_lap).to include(best_lap[0], best_lap[1])
    end

    it 'returns the correct best_lap([lap number, hash with stats])' do
      expect(mock_racer.best_lap).to eql(best_lap)
    puts "Test expects: #{best_lap} result: #{mock_racer.best_lap}"
    end
  end

  describe '#avg_speed' do
      speeds = []
      mock_racer.voltas.each {|lap_num, lap| speeds << lap[:vel_med].to_f}

    it 'returns the average speed( sum of all speeds divided by total laps)' do
      expect(mock_racer.avg_speed).to eql(speeds.sum / mock_racer.voltas.length)
      puts "Test expects: #{speeds.sum / mock_racer.voltas.length} result: #{mock_racer.avg_speed}"
    end

    it 'should return an float' do
      expect(mock_racer.avg_speed).to be_a Float
    end
  end

  describe '#avg_time_lap' do
    lap_times = []
    mock_racer.voltas.each { |lap_num, lap| lap_times << time_in_milisseconds(lap[:tempo])}
    avg_times = lap_times.sum / lap_times.length

    it 'Sum all lap times turn into millisseconds and divide by number of laps and return the average time lap in minutes' do
      expect(mock_racer.avg_time_lap).to eql(ms_to_min(avg_times))
      puts "Test expects: #{ms_to_min(avg_times)} result: #{mock_racer.avg_time_lap}"
    end

    it 'should return an float' do
      expect(mock_racer.avg_time_lap).to be_a Float
    end
  end

  describe '#times_sum' do
    times = []
    mock_racer.voltas.each { |lap_num, lap| times << time_in_milisseconds(lap[:tempo])}
    times = times.sum
    it 'Sum all lap times in ms and returns it' do
      expect(mock_racer.times_sum).to eql(times)
      puts "Test expects: #{times} result: #{mock_racer.times_sum}"
    end

    it 'should return an float' do
      expect(mock_racer.avg_speed).to be_a Float
    end
  end

  describe '.load_all_records' do
      racers_hash = {}
      racers_counter = 0
      filepath = csv_file_path
      csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
      CSV.foreach(filepath, csv_options) do |row|
        racers_hash[row["Piloto"]] = {} if racers_hash[row["Piloto"]] == nil
        racers_hash[row["Piloto"]].store(:codigo, row["Codigo"]) if racers_hash[row["Piloto"]][:codigo] == nil
        racers_hash[row["Piloto"]].store(:voltas, {}) if racers_hash[row["Piloto"]][:voltas] == nil
        racers_hash[row["Piloto"]][:voltas].store( row["Nº Volta"], {hora: row["Hora"], tempo: row["Tempo da Volta"], vel_med: row["Velocidade média da volta"]})
      end
      racers_hash.each {|x,y| racers_counter += 1 }

    it 'opens a csv and instanciate a RaceRecord for each line' do
      expect(RACER_RECORDS.length).to eql(racers_counter + 1) #Added the mock racer created in this test file
      puts "Test expects RACER_RECORDS.length + 1 mock racer to be: #{racers_counter + 1} result: #{RACER_RECORDS.length}"
    end

    it 'should create instances of RaceRecord' do
      expect(RACER_RECORDS[0]).to be_a RacerRecord
    end
  end
end
