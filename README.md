# TEST JOB
I decided to have realtime updates with ActionCable from Rails 5. There might be couple deprecation warnings due to unstable Rails version (beta 3), so just ignore them.

## Configuration & Startup
#### Server
* `cd server`
* Copy `config/secrets.yml.example` to `config/secrets.yml` and provide an url to your Redis
* Copy `config/cable.yml.example` to `config/cable.yml` and also provide an url to your Redis
* `bundle`
* `bin/rake db:setup`
* `bin/sidekiq` to enable background jobs processing
* `bin/rake messages:start_job` to start the MessagesFetcher loop
* `bin/rails s`

#### Client
* `cd client`
* Edit the redis url in the `bike.rb` or leave it if your address equals to `redis://localhost:6379`

## Messaging
#### Server side
Just type ``http://localhost:3000` in your browser

#### Client side
Run `ruby client/client.rb <CLIENT_ID>` to send a message with provided `CLIENT ID` and random generated 500 chars message.

## Questions

1) The size depends on two things - `client_id` length and content character types. Assuming that client_id has always 10 characters and content has no special chars data size is `539 bytes`, but with additional headers whole package size is `582 bytes`.

2) There are always 2 sets of data per action through the client/server pipeline - message packet and information in return. Message packet size is `582 bytes`, the information in return size is about `5 bytes`. It gives us about `464` messages per day.

3) In my opinion the best strategy to test this client/server application is to focus more on integration/acceptance tests rather than units. Of course we need basic unit tests, but the most important thing is the fact that something was sent to or pulled form the Redis server. We should allow your code to be executed without any stubs/mocks and interact with some kind of fake redis server (in memory) or even with a real one (only for tests purposes). We could simulate a client in the server application and vice versa, but we're not expecting any return messages, so this is not necessary. So far there is no interaction with external vendors so there is no need to record and stub for requests. Tests should cover all boundary scenarios to be 99% sure both apps are reliable.
