# A partir de um input de um arquivo de log do formato acima,
# montar o resultado da corrida com as seguintes
# informações: Posição Chegada, Código Piloto, Nome Piloto, Qtde Voltas Completadas e Tempo Total de Prova.
class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    puts "GymPass - Corridas"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.results
    when 2 then @controller.best_laps
    when 3 then @controller.show_avg
    when 4 then @controller.racer_difference
    when 5 then stop
    else
      puts "Por favor se atenha a 1, 2, 3, 4 e 5"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts "O que quer fazer?"
    puts "1 - Mostrar Resultados da corrida"
    puts "2 - Mostrar Melhor Volta de Cada Piloto"
    puts "3 - Calcular a velocidade média de cada piloto durante toda corrida"
    puts "4 - Descobrir quanto tempo cada piloto chegou após o vencedor"
    puts "5 - Stop and exit the program"
  end
end
