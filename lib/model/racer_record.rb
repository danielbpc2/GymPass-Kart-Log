require 'csv'
require_relative '../utils/helpers'

RACER_RECORDS = []

class RacerRecord
  attr_reader :codigo, :piloto, :voltas

  def initialize(piloto, codigo, n_volta )
    @piloto = piloto
    @codigo = codigo
    @voltas = n_volta
    RACER_RECORDS << self
  end

  #  returns racer best lap
  def best_lap
    best_lap = []
    self.voltas.each { |key, value| best_lap << [key, value] }
    best_lap.sort! {|x,y| x[1][:tempo] <=> y[1][:tempo]}
    best_lap = best_lap[0]
    return best_lap
  end

  #  returns racer average speed through the race
  def avg_speed
    speeds = []
    self.voltas.each { |key, value| speeds << value[:vel_med].to_f}
    avg_speed = speeds.sum / speeds.length
    return avg_speed
  end

  #  returns racer average time laps through the race
  def avg_time_lap
    times = []
    self.voltas.each { |key, value| times << time_in_milisseconds(value[:tempo])}
    avg_times = times.sum / times.length
    return ms_to_min(avg_times)
  end

  #  returns sum of all laps times
  def times_sum
    times = []
    self.voltas.each { |key, value| times << time_in_milisseconds(value[:tempo])}
    time_sum = times.sum
    return time_sum
  end

  # Load csv and instanciate all race records
  def self.load_all_records
    racers_hash = {}
    filepath = './db/kart_log.csv'
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(filepath, csv_options) do |row|
      racers_hash[row["Piloto"]] = {} if racers_hash[row["Piloto"]] == nil
      racers_hash[row["Piloto"]].store(:codigo, row["Codigo"]) if racers_hash[row["Piloto"]][:codigo] == nil
      racers_hash[row["Piloto"]].store(:voltas, {}) if racers_hash[row["Piloto"]][:voltas] == nil
      racers_hash[row["Piloto"]][:voltas].store( row["Nº Volta"], {hora: row["Hora"], tempo: row["Tempo da Volta"], vel_med: row["Velocidade média da volta"]})
    end
    racers_hash.each do |key, value|
      RacerRecord.new(key, value[:codigo], value[:voltas])
    end
  end
end
