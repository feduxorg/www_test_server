require 'spec_helper'

describe FiletypeDetector do
  describe '#use' do
    let(:detector) { FiletypeDetector.new }
    let(:file) { double 'file' }

    context 'when filetype is known' do
      before :each do
        write_file('file.html', '<html></html>')
      end

      before :each do
        expect(file).to receive(:path).and_return(expand_path('file.html'))
        expect(file).to receive(:filetype=).with('HTML document, ASCII text, with no line terminators')
      end

      it  { expect { detector.use(file) }.not_to raise_error }
    end

    context 'when error occured during filetype detection' do
      let(:test_file) { SecureRandom.hex }

      before :each do
        expect(file).to receive(:path).and_return(test_file)
        allow(file).to receive(:name).and_return(File.basename(test_file))
        expect(file).to receive(:filetype=).with("cannot open `#{test_file}' (No such file or directory)")
      end

      it  { expect { detector.use(file) }.not_to raise_error }
    end
  end
end
