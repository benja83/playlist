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

        expect(logger).to receive(:info).with(/#{file.inspect}/).once

        described_class.new.import(file)
      end
    end
  end
end
