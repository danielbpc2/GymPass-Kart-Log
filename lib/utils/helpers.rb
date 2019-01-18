def time_in_milisseconds(time)
  time_string = time.split(':')

  milliseconds = time_string.last.split('.').last
  totalmilliseconds = time_string.last.split('.').first.to_i * 1000 + milliseconds.to_i
  minutes = time_string.first.to_i * 60000
  return totalmilliseconds + minutes
end

def ms_to_min(ms)
  tempo = (ms.to_f / 1000) / 60
  return tempo
end

def get_avg(array)
  return array.sum / array.length
end
