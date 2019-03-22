require 'spec_helper'

describe VirusDetector do
  let(:file) { double 'file' }
  let(:virusscanner) { which('clamscan') }
  let(:detector) { VirusDetector.new(command: virusscanner) }
  let(:data) { 'data' }


  context '#use' do
    before :each do
      write_file('file.txt', data)
    end

    before :each do
      allow(file).to receive(:name).and_return('file.txt')
      allow(file).to receive(:path).and_return(expand_path('file.txt'))
    end

    context 'when no virus was found' do
      before :each do
        expect(file).to receive(:virus_id=).with(nil)
      end

      it { expect { detector.use(file) }.not_to raise_error }
    end

    context 'when virus was found' do
      let(:data) { eicar_test_string }

      before :each do
        expect(file).to receive(:virus_id=).with('Eicar-Test-Signature')
      end

      it { expect { detector.use(file) }.not_to raise_error }
    end

    context 'when virus scanner could not be found' do
      let(:virusscanner) { nil }

      before :each do
        expect(file).to receive(:virus_id=).with("Scan commands \"clamdscan\" and \"clamscan\" not found. File \"file.txt\" could not be scanned.")
      end

      it { expect { detector.use(file) }.not_to raise_error }
    end
  end
end
