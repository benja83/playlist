# frozen_string_literal: true

require 'rails_helper'

describe User do
  it 'includes the importable concern' do
    expect(described_class.ancestors.include?(Importable)).to eq(true)
  end
end
