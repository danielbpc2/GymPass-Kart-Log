class RacerRecordsController
  def initialize(csv_file_path = '')
    # Load csv and instanciate all race records
    # Carrega o csv e instancia todos os RaceRecords
    RacerRecord.load_all_records(csv_file_path)
    # create view
    # Cria a view
    @view = RaceView.new
  end

  # create the results of the race and send to view to display
  # cria os resultados da corrida e envia para a view mostrar
  def results
    results = result_maker(RACER_RECORDS)
    total_time = total_time_maker(RACER_RECORDS)
    @view.display_results(results, total_time)
  end

  # sends an array of the best laps to view to display
  # envia um arrai com as melhores voltas para a view mostrar
  def best_laps
    best_laps = []
    RACER_RECORDS.each {|racer| best_laps << [ racer.piloto, racer.best_lap ]}
    @view.display_best_laps(best_laps)
  end

  # sends an array with individual average times and sends to view to display
  # envia um array com as medias individuais de tempo para a view mostrar
  def show_avg_time
    avg_times = []
    RACER_RECORDS.each {|racer| avg_times << [ racer.piloto, racer.avg_time_lap ]}
    @view.display_avg_times(avg_times)
  end

  # sends an array with individual average speeds and sends to view to display
  # envia um array com as medias individuais de velocidade para a view mostrar
  def show_avg_speed
    avg_speeds = []
    RACER_RECORDS.each {|racer| avg_speeds << [ racer.piloto, racer.avg_speed ]}
    @view.display_avg_speeds(avg_speeds)
  end

  # sends an array with time difference from winner and sends to view to display
  # envia um array com a diferença de tempo entre o primeiro e o segundo para a view mostrar
  def racer_difference
    times = []
    winner_time = result_maker(RACER_RECORDS)['1'].times_sum
    RACER_RECORDS.each {|racer| times << [ racer.piloto, racer.times_sum ]}
    @view.display_time_from_first(times.sort { |x,y| x[1] <=> y[1] }, winner_time)
  end

  private

  # receives the RacerRecords, sort by the hour that the last lap was made and return the Race results
  # recebe todas as RacerRecords, orderna por hora de termino de suas ultimas voltas e retorna o resultado da corrida
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

  # receive the RacerRecords, sums the total time each racer took in the race, and return the total time and each racer time had inside the race
  # recebe todas as RacerRecords, soma o tempo total de cada corredor teve na corrida, e retorna o tempo total e o tempo de cada corredor na corrida
  def total_time_maker(records)
    sorted_records = records.sort { |x,y| x.voltas[x.voltas.keys.last][:hora] <=> y.voltas[y.voltas.keys.last][:hora] }

    time_results = {}
    position_counter = 0
    total_time = 0

    sorted_records.each do |racer|
      position_counter += 1
      total_time += racer.times_sum
      individual_time = racer.times_sum
      time_results.store("#{position_counter}", ms_to_min(individual_time))
    end

    return [ms_to_min(total_time), time_results]
  end
end
