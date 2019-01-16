require_relative '../model/LapRecord'
require_relative '../views/LapView'
require_relative '../utils/helpers'

class LapRecordsController
  def initialize
    LapRecord.load_all_Records
    @view = LapView.new
  end

  def results
    results = winner(LAP_RECORDS)
    @view.display_results(results)
  end

  # private

  def winner(records)

  end

  def tempo_total(records, racer)

  end
end
