class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end
# roda o app entrando em loop
  def run
    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private
# ações que o user pode fazer
  def route_action(action)
    case action
    when 1 then @controller.results
    when 2 then @controller.best_laps
    when 3 then @controller.show_avg_speed
    when 4 then @controller.show_avg_time
    when 5 then @controller.racer_difference
    when 6 then stop
    else
      puts "Por favor se atenha a 1, 2, 3, 4, 5 e 6"
    end
  end

# para o router
  def stop
    @running = false
  end
# print do console:
  def display_tasks
    puts "============================="
    puts "GymPass - Corridas"
    puts "============================="
    puts "Opções:"
    puts "1 - Mostrar Resultados da corrida"
    puts "2 - Mostrar Melhor Volta de Cada Piloto"
    puts "3 - Calcular a velocidade média de cada piloto durante toda corrida"
    puts "4 - Calcular a tempo médio de cada volta de cada piloto"
    puts "5 - Descobrir quanto tempo cada piloto chegou após o vencedor"
    puts "6 - Parar e sair do programa"
  end
end
