# frozen_string_literal: true

require 'rails_helper'

describe Importers::Users do
  describe '#import' do
    context 'when importing a csv file well formated' do
      it 'creates the users with the right id' do
        file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixture/user_data.csv'))
        expect { described_class.import(file) }.to change { User.count }.by 4

        expect(User.first.id).to eq 1
        expect(User.last.id).to eq 22
      end
    end
  end
end
