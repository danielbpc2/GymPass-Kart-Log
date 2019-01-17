require_relative './lib/model/racer_record'
require_relative './lib/controller/racer_records_controller'
require_relative './lib/router'
require_relative './lib/utils/log_parser'


create_csv_from_txt

controller = RacerRecordsController.new

router = Router.new(controller)

# Start the app
router.run

