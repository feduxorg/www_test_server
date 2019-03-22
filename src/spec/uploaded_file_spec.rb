# encoding: utf-8
require 'spec_helper'

describe UploadedFile do
  context '#initialize' do
    it 'requires an uploaded file' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      UploadedFile.new(uploaded_file)
    end
    
    it 'handles empty string' do
      expect {
        UploadedFile.new('')
      }.not_to raise_error
    end
  end

  context '#path' do
    it 'returns path for uploaded file' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)
      allow(uploaded_file).to receive(:path).and_return('/tmp/filename.png')

      file = UploadedFile.new(uploaded_file)
      expect(file.path).to eq('/tmp/filename.png')
    end
  end

  context '#name' do
    it 'returns basename for uploaded file' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)
      allow(uploaded_file).to receive(:original_filename).and_return('filename.png')

      file = UploadedFile.new(uploaded_file)
      expect(file.name).to eq('filename.png')
    end
  end

  context '#contains_virus?' do
    it 'is false if does not contain virus' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)
      expect(file.contains_virus?).to be_falsey
    end
  end

  context '#virus_id' do
    it 'sets a virus id' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)

      expect {
        file.virus_id = 'EICAR'
      }.not_to raise_error
    end

    it 'returns a virus id' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)
      file.virus_id = 'EICAR'

      expect(file.virus_id).to eq 'EICAR'
    end
  end

  context '#has_filetype?' do
    it 'is false if has no filetype' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)
      expect(file.has_filetype?).to be_falsey
    end
  end

  context '#filetype' do
    it 'sets a filetype' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)

      expect {
        file.filetype = 'Text'
      }.not_to raise_error
    end

    it 'returns a filetype' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)
      file.filetype = 'Text'

      expect(file.filetype).to eq 'Text'
    end
  end

  context '#checksum=' do
    it 'sets the checksum for file' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)

      expect {
        file.checksum = Digest::SHA256.hexdigest 'message'
      }.not_to raise_error
    end
  end

  context '#checksum' do
    it 'returns checksum hash for content' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      checksum      = Digest::SHA256.hexdigest 'message'

      file = UploadedFile.new(uploaded_file)
      file.checksum = checksum

      expect(file.checksum.first).to eq(checksum)
    end
  end

  context '#has_checksum' do
    it 'is false if has no checksum' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)
      expect(file.has_checksum?).to be_falsey
    end

    it 'is true if has a checksum' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)

      file = UploadedFile.new(uploaded_file)
      file.checksum = Digest::SHA256.hexdigest 'message'
      expect(file.has_checksum?).to be_truthy
    end
  end

  context '#size' do
    it 'returns the file size' do
      uploaded_file = double('ActionDispatch::Http::UploadedFile')
      allow(uploaded_file).to receive(:tempfile)
      allow(uploaded_file).to receive(:size).and_return 4294967296

      file = UploadedFile.new(uploaded_file)
      expect(file.size[:b].value).to eq('4294967296')
      expect(file.size[:kib].value).to eq('4194304.00')
      expect(file.size[:mib].value).to eq('4096.00')
      expect(file.size[:gib].value).to eq('4.00')
    end
  end
end
