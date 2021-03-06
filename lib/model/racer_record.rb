# All racer records saved in this constant
# todos os logs dos corredores são salvos nessa constante
RACER_RECORDS = []

class RacerRecord
  attr_reader :codigo, :piloto, :voltas

  def initialize(piloto, codigo, n_volta = {})
    @piloto = piloto
    @codigo = codigo
    @voltas = n_volta
    # saves the instance inside the RACER_RECORDS constant
    # salva instancias dentro de RACER_RECORDS
    RACER_RECORDS << self
  end

  #  returns racer best lap
  def best_lap
    best_lap = []
    self.voltas.each { |lap_num, lap_stat| best_lap << [lap_num, lap_stat] }
    best_lap.sort! {|x,y| x[1][:tempo] <=> y[1][:tempo]}
    best_lap = best_lap[0]
    return best_lap
  end

  #  returns racer average speed through the race
  # retorna a media de velocidade do piloto durante a corrida
  def avg_speed
    speeds = []
    self.voltas.each { |lap_num, lap_stat| speeds << lap_stat[:vel_med].to_f}
    return get_avg(speeds)
  end

  #  returns racer average time laps through the race
  #  returna a media de tempo das voltas durante a corrida
  def avg_time_lap
    times = []
    self.voltas.each { |lap_num, lap_stat| times << time_in_ms(lap_stat[:tempo])}
    return ms_to_min(get_avg(times))
  end

  #  returns sum of all laps times
  #  retorna a soma dos tempos das voltas
  def times_sum
    time_sum = 0
    self.voltas.each { |lap_num, lap_stat| time_sum += time_in_ms(lap_stat[:tempo])}
    return time_sum
  end

  private
  # Load csv and instanciate all race records
  # carrega o csv e instacia todos os RaceRecords
  def self.load_all_records(csv_file_path)
    racers_hash = {}
    filepath = csv_file_path
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(filepath, csv_options) do |row|
      racers_hash[row["Piloto"]] = {} if racers_hash[row["Piloto"]] == nil
      racers_hash[row["Piloto"]].store(:codigo, row["Codigo"]) if racers_hash[row["Piloto"]][:codigo] == nil
      racers_hash[row["Piloto"]].store(:voltas, {}) if racers_hash[row["Piloto"]][:voltas] == nil
      racers_hash[row["Piloto"]][:voltas].store( row["Nº Volta"], {hora: row["Hora"], tempo: row["Tempo da Volta"], vel_med: row["Velocidade média da volta"]})
    end
    racers_hash.each do |lap_num, lap_stat|
      RacerRecord.new(lap_num, lap_stat[:codigo], lap_stat[:voltas])
    end
  end
end
