require_relative 'RacerRecord'
require 'csv'

LAP_RECORDS = []

class LapRecord
  attr_accessor :hora, :codigo, :piloto, :n_volta, :tempo, :vel_med

  def initialize(hora, codigo, piloto, n_volta, tempo, vel_med)
    @hora = hora
    @codigo = codigo
    @piloto = piloto
    @n_volta = n_volta.to_i
    @tempo = tempo
    @vel_med = vel_med.to_f
    LAP_RECORDS << self
  end

  private

  def self.load_all_Records
    filepath = './db/kart_log.csv'
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(filepath, csv_options) do |row|
      LapRecord.new(row["Hora"], row["Codigo"], row["Piloto"], row["Nº Volta"], row["Tempo da Volta"], row["Velocidade média da volta"])
    end
  end

  def self.save_all_Records
    filepath = './db/kart_log.csv'
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(filepath, "wb", csv_options) do |csv|
      csv << ["Hora", "Codigo", "Piloto", "Nº Volta", "Tempo da Volta", "Velocidade média da volta"]
      LAP_RECORDS.each do |record|
        csv << [record.hora, record.codigo, record.piloto, record.n_volta, record.tempo, record.vel_med]
      end
    end
  end
end
