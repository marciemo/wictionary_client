HOSTNAME = 'http://localhost:3000'
VALID_LIST_RESPONSE = "[{\"word\":{\"created_at\":\"2013-03-25T21:38:59Z\",\"definition\":null,\"entry\":\"potpie\",\"id\":1,\"updated_at\":\"2013-03-25T21:38:59Z\"}},{\"word\":{\"created_at\":\"2013-03-26T00:06:19Z\",\"definition\":null,\"entry\":\"lizard\",\"id\":2,\"updated_at\":\"2013-03-26T00:06:19Z\"}},{\"word\":{\"created_at\":\"2013-03-26T16:51:47Z\",\"definition\":\"something new\",\"entry\":\"gatorade\",\"id\":3,\"updated_at\":\"2013-03-26T16:51:47Z\"}}]"
require 'rspec'
require 'faraday'
require 'json'
require 'webmock/rspec'

require 'contribution'