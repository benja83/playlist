# frozen_string_literal: true

require 'rails_helper'

describe Importable do
  it 'gives the import method to the model' do
    class DummyClass
      include Importable
    end

    expect(DummyClass).to respond_to(:import)
  end

  it 'instanciates a importer object when using the import method' do
    class DummyClass
      include Importable
    end
    importer = double('importer', import: nil)

    expect(Importers::DataWithoutAssociation).to receive(:new).with('DummyClass')
      .and_return(importer)

    DummyClass.import(double('file'))
  end
end
