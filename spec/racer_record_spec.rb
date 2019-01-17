require 'rspec'
require_relative '../lib/model/racer_record'
require_relative '../lib/utils/helpers'

RacerRecord.load_all_records('./spec/mock_db/kart_log.csv')
extra_mock_racer_daniel = RacerRecord.new("Daniel", "007", {
  "1"=>{:hora=>"11:00:00.666", :tempo=>"1:00.444", :vel_med=>"69.000"},
  "2"=>{:hora=>"11:01:02.000", :tempo=>"1:01.000", :vel_med=>"69.000"},
  "3"=>{:hora=>"11:02:03.000", :tempo=>"1:02.000", :vel_med=>"69.000"},
  "4"=>{:hora=>"11:03:06.000", :tempo=>"1:03.000", :vel_med=>"69.000"}
})

mock_racer = RACER_RECORDS[-1]
puts "Racer the test is using: {#{mock_racer.piloto},#{mock_racer.codigo}, #{mock_racer.voltas}}"

describe RacerRecord do
  describe '#best_lap' do
    it 'Creates an empty array and populate it with the racer laps, in the end returns the best_lap([lap number, hash with stats])' do
      best_lap = []
      mock_racer.voltas.each { |lap_num, lap| best_lap << [lap_num, lap] }
      best_lap.sort! {|x,y| x[1][:tempo] <=> y[1][:tempo]}
      best_lap = best_lap[0]
      expect(mock_racer.best_lap).to eql(best_lap)
    end
  end

  describe '#avg_speed' do
    it 'returns the average speed( sum of all speeds divided by total laps)' do
        speeds = []
        mock_racer.voltas.each {|lap_num, lap| speeds << lap[:vel_med].to_f}
        expect(mock_racer.avg_speed).to eql(speeds.sum / mock_racer.voltas.length)
    end
  end

  describe '#avg_time_lap' do
    it 'Sum all lap times turn into millisseconds and divide by number of laps and return the average time lap in minutes' do
      lap_times = []
      mock_racer.voltas.each { |lap_num, lap| lap_times << time_in_milisseconds(lap[:tempo])}
      avg_times = lap_times.sum / lap_times.length
      expect(mock_racer.avg_time_lap).to eql(ms_to_min(avg_times))
    end
  end

  describe '#times_sum' do
    it 'Sum all lap times in ms and returns it' do
      times = []
      mock_racer.voltas.each { |lap_num, lap| times << time_in_milisseconds(lap[:tempo])}

    end
  end
end

