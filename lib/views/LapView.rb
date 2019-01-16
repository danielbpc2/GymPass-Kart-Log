# informações: Posição Chegada, Código Piloto, Nome Piloto, Qtde Voltas Completadas e Tempo Total de Prova.
class LapView
  def display_results(results)
    puts("Resultados da Corrida:")
    puts("---------------")
    results.each_with_index do |racer, index|
    puts "\##{index + 1}: #{racer.codigo} - #{racer.piloto} - Voltas Completadas: #{racer.n_volta}, Tempo Total de Prova: "
    end
    puts("---------------")
  end
end
