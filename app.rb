require_relative './lib/model/LapRecord'
require_relative './lib/controller/LapRecordsController'
require_relative './lib/router'
require_relative './lib/utils/log_parser'


create_csv_from_txt

controller = LapRecordsController.new

router = Router.new(controller)

# Start the app
router.run
