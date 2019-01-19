require 'csv'
require 'json'

# Takes a TXT and create a CSV of it and return a string with its directory
def create_csv_from_txt(txt_file_path)
  record_lines = []
  File.open(txt_file_path, "r") do |f|
    f.each_line do |line|
      details = []
      details << line.split(' ') unless line[0] == 'H'
      details.each do |record|
        record.delete_at(2)
        record[2] = 'F.MASSA' if record[2] == 'F.MASS'
        record[5].gsub!(/,/, '.')
        record_lines << record
      end
    end
  end
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  CSV.open("./db/kart_log.csv", "wb", csv_options) do |csv|
    csv << ["Hora", "Codigo", "Piloto", "Nº Volta", "Tempo da Volta", "Velocidade média da volta"]
    record_lines.each {|line| csv <<  line}
  end
  return "./db/kart_log.csv"
end

# Takes a TXT and create a JSON of it and return a string with its directory
def create_json_from_txt(txt_file_path)
  record_lines = []
  objects = {}
  File.open(txt_file_path, "r") do |f|
    f.each_line do |line|
      details = []
      details << line.split(' ') unless line[0] == 'H'
      details.each do |record|
        record.delete_at(2)
        record[2] = 'F.MASSA' if record[2] == 'F.MASS'
        record[5].gsub!(/,/, '.')
        record_lines << record
      end
    end
  end
  record_lines.each do |line|
      objects[line[2]] = {} if objects[line[2]] == nil
      objects[line[2]].store(:nome, line[2]) if objects[line[2]][:nome] == nil
      objects[line[2]].store(:codigo, line[1]) if objects[line[2]][:codigo] == nil
      objects[line[2]].store(:voltas, {}) if objects[line[2]][:voltas] == nil
      objects[line[2]][:voltas].store( line[3], {hora: line[0], tempo: line[4], vel_med: line[5]})
  end
  File.write('./db/kart_log.json',JSON.generate(objects))
  return "./db/kart_log.json"
end
