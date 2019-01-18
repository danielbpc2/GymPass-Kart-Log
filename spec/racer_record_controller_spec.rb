require 'rspec'
require_relative '../lib/model/racer_record'
require_relative '../lib/views/race_view'
require_relative '../lib/controller/racer_records_controller'
require_relative '../lib/utils/helpers'
require 'csv'

csv_file_path = './db/kart_log.csv'
mock_controller = RacerRecordsController.new(csv_file_path)

extra_mock_racer_daniel = RacerRecord.new("Daniel", "007", {
  "1"=>{:hora=>"11:00:00.666", :tempo=>"1:00.444", :vel_med=>"69.000"},
  "2"=>{:hora=>"11:01:02.000", :tempo=>"1:01.000", :vel_med=>"69.000"},
  "3"=>{:hora=>"11:02:03.000", :tempo=>"1:02.000", :vel_med=>"69.000"},
  "4"=>{:hora=>"11:03:06.000", :tempo=>"1:03.000", :vel_med=>"69.000"}
})

describe RacerRecordsController do
  sorted_records = RACER_RECORDS.sort { |x,y| x.voltas[x.voltas.keys.last][:hora] <=> y.voltas[y.voltas.keys.last][:hora] }
  results = {}
  position_counter = 0

  sorted_records.each do |racer|
    position_counter += 1
    results.store("#{position_counter}", racer)
  end

  describe '#result_maker' do
    it 'receives the RacerRecords, sort by the hour that the last lap was made and return the Race results' do
      expect(mock_controller.send(:result_maker, RACER_RECORDS)).to eql(results)
    end
  end

  time_results = {}
  position_counter = 0
  total_time = 0

  sorted_records.each do |racer|
    position_counter += 1
    total_time += racer.times_sum
    individual_time = racer.times_sum
    time_results.store("#{position_counter}", ms_to_min(individual_time))
  end

  describe '#total_time_maker' do
    it 'receive the RacerRecords, sums the total time each racer took in the race, and return the total time and each racer time had inside the race' do
      expect(mock_controller.send(:total_time_maker, RACER_RECORDS)).to eql([ms_to_min(total_time), time_results])
    end
  end
end

