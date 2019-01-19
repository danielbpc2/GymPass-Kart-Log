# takes time displayed like : Min:Sec.Ms and turns into ms
# pega o tempo disposto: Min:seg.ms e torna em ms
def time_in_ms(time)
  time_string = time.split(':')

  milliseconds = time_string.last.split('.').last
  totalmilliseconds = time_string.last.split('.').first.to_i * 1000 + milliseconds.to_i
  minutes = time_string.first.to_i * 60000
  return totalmilliseconds + minutes
end

# turns a amount of ms into minutes
# converte uma quantidade de ms em minutos
def ms_to_min(ms)
  tempo = (ms.to_f / 1000) / 60
  return tempo
end

# simply makes an average of an array
# simplesmente faz uma média dos itens de uma array
def get_avg(array)
  return array.sum / array.length
end
