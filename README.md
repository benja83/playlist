# Coding Challenge: Playlists

## Tasks

- Create a rails application within this repo and commit as usual
- Update the README inside with information on how to work with it if you think that some information might be helpful
- Set up an appropriate data model for the data in the csv files
- Create an import for the users
- Create a simple controller/view to show a list of users
- Create a simple REST API endpoint that returns a list of users as json. The REST API can be treated as internal only so no authentication/authorization is needed here.
- Create an import for the playlists and mp3
- Extend the users view to also show the playlists each user has

## About the app I've built

### Requirement

You need postgreSQL as database.


### Setup rails app and run rails server

```bash
bundle install

bundle exec rake db:create

bundle exec rake db:setup

bundle exec rails server
```

### Data model

- A User has many playlists, and a playlist belongs to a user.
- A playlist has many Mp3s, and Mp3 belongs to many playlists. I've used the has_many through association because it's more flexible.

### Business decision

- When having a CSV with a row with a wrong format, I decided to log the buggy row and to continue processing the rest of the file.

- I didn't invest many time in improving the UI. I'm sorry this app is not responsive, don't open it in your phone.

### External gem used

- rubocop
- factory_girl_rails
- ffaker
- database_cleaner

### Testing

I decided to test only the importers where the core logic of the code test is. I though that testing models or make integration test was not giving so much value

I have tried a new approach for testing. This approach consist in making test more readable and understandable over respecting DRY principle. When we abuse using before, let, shared_example blocks, the suite test ends being messy and it's very difficult to understand the testing context and which flow each test is following.

That's why I have write each test like a story or a scenario, splitting them in 4 phases. See the example below

```ruby
context 'when importing a CSV file well formatted' do
  it 'creates the users with the right id' do
    # Setup all the conditions required by your test
    fixture_file_path = Rails.root.join('spec/fixture/user_data.csv')
    file = Rack::Test::UploadedFile.new(fixture_file_path)

    # Exercise the method being tested
    expect { described_class.new('user').import(file) }
      .to change { User.count }.by 4

    # verify the result
    expect(User.first.id).to eq 1
    expect(User.last.id).to eq 22

    # Teardown everything that should not persist after the test has finished
    # if it's required
  end
end
```

### Improvement

- I must improve the performance.
- I can improve the error caching.
- Increase the code coverage.
- When having a CSV with buggy row, as we have more than one time the same error, as improvement, we could implement strategies to process those row. For example, we could try to map the row field with a type, in particular for the mp3_data.csv with the integer field like track and year.
- Improve the UI and show message to the user

### Feedback

Thank you for allowing me to make this code test. I've never dealt with CSV importation before and it's has been very funy and interesting. I learnt a lot doing it.

The encoding treasures included have been a WTF. But after debugging I could found the issues and begin to fix them.

