def time_in_milisseconds(time)
  time_string = time.split(':')

  milliseconds = time_string.last.split('.').last
  totalmilliseconds = time_string.last.split('.').first.to_i * 1000 + milliseconds.to_i
  minutes = time_string[1].to_i * 60000
  hours = time_string[0].to_i * 3600000
  return totalmilliseconds + minutes + hours
end

def ms_to_min(ms)
  tempo = (ms.to_f / 1000) / 60
  return tempo
end

