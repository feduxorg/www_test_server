require 'spec_helper'

describe FileDeleter do
  context '#use' do
    before :each do
      touch('file.html')
    end

    before :each do
      file = double 'file'
      expect(file).to receive(:path).and_return(expand_path('file.html'))

      actor = FileDeleter.new
      actor.use file
    end

    it { expect('file.html').not_to be_an_existing_file }
  end
end
