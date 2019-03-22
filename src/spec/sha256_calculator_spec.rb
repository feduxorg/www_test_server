require 'spec_helper'

describe Sha256Calculator do
  let(:file) { double 'file' }
  let(:detector) { Sha256Calculator.new }

  context '#use' do
    context 'when checksum can be generated' do
      before :each do
        write_file('file.html', 'data')
      end

      before :each do
        expect(file).to receive(:path).and_return(expand_path('file.html'))
        expect(file).to receive(:checksum=) do |arg|
          expect(arg.algorithm).to eq(:sha256)
          expect(arg.value).to eq(Digest::SHA256.hexdigest('data'))
        end
      end

      it { expect { detector.use(file) }.not_to raise_error }
    end

    context 'when not check sum can be generated' do
      let(:test_file) { SecureRandom.hex }

      before :each do
        allow(file).to receive(:path).and_return(test_file)
        allow(file).to receive(:name).and_return(File.basename(test_file))
        expect(file).to receive(:checksum=) do |arg|
          expect(arg.value).to eq("An error occured while determine checksum for \"#{test_file}\".")
        end
      end

      it { expect { detector.use(file) }.not_to raise_error }
    end
  end
end
