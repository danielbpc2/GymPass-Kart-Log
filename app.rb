require_relative './lib/model/racer_record'
require_relative './lib/views/race_view'
require_relative './lib/controller/racer_records_controller'
require_relative './lib/utils/log_parser'
require_relative './lib/router'
require_relative './lib/utils/helpers'

txt_file_path = './db/kart_log.txt'

controller = RacerRecordsController.new(create_csv_from_txt(txt_file_path))

router = Router.new(controller)

# Start the app
router.run

