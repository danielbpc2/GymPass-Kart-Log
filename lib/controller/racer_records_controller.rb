require_relative '../model/racer_record'
require_relative '../views/race_view'
require_relative '../utils/helpers'

class RacerRecordsController
  def initialize(csv_file_path)
    # Load csv and instanciate all race records
    RacerRecord.load_all_records(csv_file_path)
    # create view
    @view = RaceView.new
  end

  # create the results of the race and send to view to display
  def results
    results = result_maker(RACER_RECORDS)
    total_time = total_time_maker(RACER_RECORDS)
    @view.display_results(results, total_time)
  end

  # sends an array of the best laps to view to display
  def best_laps
    best_laps = []
    RACER_RECORDS.each {|racer| best_laps << [ racer.piloto, racer.best_lap ]}
    @view.display_best_laps(best_laps)
  end

  # sends an array with individual average times and sends to view to display
  def show_avg_time
    avg_times = []
    RACER_RECORDS.each {|racer| avg_times << [ racer.piloto, racer.avg_time_lap ]}
    @view.display_avg_times(avg_times)
  end

  # sends an array with individual average speeds and sends to view to display
  def show_avg_speed
    avg_speeds = []
    RACER_RECORDS.each {|racer| avg_speeds << [ racer.piloto, racer.avg_speed ]}
    @view.display_avg_speeds(avg_speeds)
  end

  # sends an array with time difference from winner and sends to view to display
  def racer_difference
    times = []
    winner_time = result_maker(RACER_RECORDS)['1'].times_sum
    RACER_RECORDS.each {|racer| times << [ racer.piloto, racer.times_sum ]}
    @view.display_time_from_first(times.sort { |x,y| x[1] <=> y[1] }, winner_time)
  end

  private

  # receives the records and return the Race results
  def result_maker(records)
    sorted_records = records.sort { |x,y| x.voltas[x.voltas.keys.last][:hora] <=> y.voltas[y.voltas.keys.last][:hora] }

    results = {}
    position_counter = 0

    sorted_records.each do |racer|
      position_counter += 1
      results.store("#{position_counter}", racer)
    end

    return results
  end

  # receive the records and return the total time each racer had inside the race
  def total_time_maker(records)
    sorted_records = records.sort { |x,y| x.voltas[x.voltas.keys.last][:hora] <=> y.voltas[y.voltas.keys.last][:hora] }

    time_results = {}
    position_counter = 0

    sorted_records.each do |racer|
      all = 0
      position_counter += 1
      racer.voltas.keys.each { |key| all += time_in_milisseconds(racer.voltas[key][:tempo]) }
      total_time = ms_to_min(all).round(2)
      time_results.store("#{position_counter}", total_time)
    end

    return time_results
  end
end
