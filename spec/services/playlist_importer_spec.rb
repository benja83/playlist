# frozen_string_literal: true

require 'rails_helper'

describe PlaylistImporter do
  describe '#import' do
    context 'when starting the importation' do
      let(:logger) { instance_double(Logger) }
      it 'logs information about the file' do
        fixture_file_path = Rails.root.join('spec/fixture/playlist_data.csv')
        file = Rack::Test::UploadedFile.new(fixture_file_path)
        allow(Logger).to receive(:new).and_return(logger)
        create(:user, id: 1)
        (1..6).each { |id| create(:mp3, id: id) }

        expect(logger).to receive(:info).with(/#{file.inspect}/).once

        described_class.new.import(file)
      end
      it 'creates the mp3 associated to the playlist' do
        fixture_file_path = Rails.root.join('spec/fixture/playlist_data.csv')
        file = Rack::Test::UploadedFile.new(fixture_file_path)
        allow(Logger).to receive(:new).and_return(logger)
        allow(logger).to receive(:info)

        user = create(:user, id: 1)
        (1..6).each { |id| create(:mp3, id: id) }

        described_class.new.import(file)

        expect(user.playlists.first.mp3_ids).to include(1, 2)
        expect(user.playlists[1].mp3_ids).to include(3, 4)
        expect(user.playlists.last.mp3_ids).to include(5, 6)
      end
    end
  end
end
