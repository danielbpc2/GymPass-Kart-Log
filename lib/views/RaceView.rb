# informações: Posição Chegada, Código Piloto, Nome Piloto, Qtde Voltas Completadas e Tempo Total de Prova.
class RaceView
  def display_results(results, total_time)
    puts("Resultados da Corrida:")
    puts("---------------")
    results.each do |key, value|
    puts "\##{key}: #{value.codigo} - #{value.piloto}, Voltas Completadas: #{value.voltas.keys.length}, Tempo Total de Prova: #{total_time[key]} minutos"
    end
    puts("---------------")
  end

  def display_best_laps(best_laps)
    puts("Melhores Tempos Individuais:")
    puts("---------------")
    best_laps.each do |laps|
    puts "#{laps[0]} - Volta: #{laps[1][0]} - Tempo: #{laps[1][1][:tempo]}"
    end
    puts("---------------")
  end

  def display_avg_times(avg_times)
    puts("Tempo Médio De Voltas:")
    puts("---------------")
    avg_times.each do |array|
    puts "#{array[0]} - Tempo Médio: #{array[1]}"
    end
    puts("---------------")
  end

  def display_avg_speeds(avg_speeds)
    puts("Velocidade Média Das Voltas:")
    puts("---------------")
    avg_speeds.each do |array|
    puts "#{array[0]} - Velocidade Média: #{array[1].round(2)}"
    end
    puts("---------------")
  end

  def display_time_from_first(times, winner_time)
    puts("Quanto Tempo Cada Piloto Chegou Após o Vencedor:")
    puts("---------------")
    times.each do |array|
    puts "#{array[0]} - Tempo de Chegada após: #{(array[1] - winner_time)/ 1000.0} segundos"
    end
    puts("---------------")
  end
end
