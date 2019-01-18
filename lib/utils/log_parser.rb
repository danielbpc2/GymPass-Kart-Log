require 'csv'

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
