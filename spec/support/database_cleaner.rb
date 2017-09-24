# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation, pre_count: true, reset_ids: true)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # config.before(:each) do
  #   User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')
  #   Mp3.connection.execute('ALTER SEQUENCE mp3_id_seq RESTART WITH 1')
  # end
end
