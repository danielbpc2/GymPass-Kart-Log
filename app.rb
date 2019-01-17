require_relative './lib/model/RacerRecord'
require_relative './lib/controller/RacerRecordsController'
require_relative './lib/router'
require_relative './lib/utils/log_parser'


create_csv_from_txt

controller = RacerRecordsController.new

router = Router.new(controller)

# Start the app
router.run

