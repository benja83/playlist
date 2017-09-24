# frozen_string_literal: true

require 'rails_helper'

describe Importers::DataWithoutAssociation do
  describe '#import' do
    context 'when importing user_data' do
      let(:logger) { instance_double(Logger) }
      context 'when starting the importation' do
        it 'logs information about the file' do
          fixture_file_path = Rails.root.join('spec/fixture/user_data.csv')
          file = Rack::Test::UploadedFile.new(fixture_file_path)
          allow(Logger).to receive(:new).and_return(logger)

          expect(logger).to receive(:info).with(/#{file.inspect}/).once

          described_class.new('user').import(file)
        end
      end
      context 'when importing a csv file well formated' do
        it 'creates the users with the right id' do
          fixture_file_path = Rails.root.join('spec/fixture/user_data.csv')
          file = Rack::Test::UploadedFile.new(fixture_file_path)

          expect { described_class.new('user').import(file) }
            .to change { User.count }.by 4
          expect(User.first.id).to eq 1
          expect(User.last.id).to eq 22
        end
      end
      context 'when importing a csv file wrong formated' do
        it 'creates the users with the right id and log the error' do
          filename = 'user_data_wrong_format.csv'
          fixture_file_path = Rails.root.join("spec/fixture/#{filename}")
          file = Rack::Test::UploadedFile.new(fixture_file_path)

          allow(Logger).to receive(:new).and_return(logger)
          allow(logger).to receive(:info)

          expect(logger).to receive(:error)
            .with(include('have an error ActiveRecord::UnknownAttributeError: unknown '\
              "attribute '' for User. You must take a look to the original file"))
            .once
          expect { described_class.new('user').import(file) }
            .to change { User.count }.by 3
          expect(User.first.id).to eq 1
        end
      end
    end

    context 'when importing mp3_data' do
      let(:logger) { instance_double(Logger) }
      context 'when starting the importation' do
        it 'logs information about the file' do
          fixture_file_path = Rails.root.join('spec/fixture/mp3_data.csv')
          file = Rack::Test::UploadedFile.new(fixture_file_path)
          allow(Logger).to receive(:new).and_return(logger)

          expect(logger).to receive(:info).with(/#{file.inspect}/).once

          described_class.new('mp3').import(file)
        end
      end
      context 'when importing a csv file well formated' do
        it 'creates the users with the right id' do
          fixture_file_path = Rails.root.join('spec/fixture/mp3_data.csv')
          file = Rack::Test::UploadedFile.new(fixture_file_path)

          expect { described_class.new('mp3').import(file) }
            .to change { Mp3.count }.by 4
          expect(Mp3.first.id).to eq 1
          expect(Mp3.last.id).to eq 22
        end
      end
      context 'when importing a csv file wrong formated' do
        it 'creates the users with the right id and log the error' do
          filename = 'mp3_data_wrong_format.csv'
          fixture_file_path = Rails.root.join("spec/fixture/#{filename}")
          file = Rack::Test::UploadedFile.new(fixture_file_path)

          allow(Logger).to receive(:new).and_return(logger)
          allow(logger).to receive(:info)

          expect(logger).to receive(:error)
            .with(include('have an error ActiveRecord::UnknownAttributeError: unknown '\
              "attribute '' for Mp3. You must take a look to the original file"))
            .once
          expect { described_class.new('mp3').import(file) }
            .to change { Mp3.count }.by 3
          expect(Mp3.first.id).to eq 1
        end
      end
    end
  end
end
