# encoding: utf-8
require 'spec_helper'

describe "file_uploader/upload.html.haml" do
  context 'File Upload' do
    it 'returns file name' do
      visit '/file_uploader/upload'

      within 'form' do
        attach_file 'test_server_file_upload[uploaded_file]', fixture_file('file_uploader/file.bin').path
      end

      click_button 'upload'

      expect(page).to have_content 'Size'
    end

    it 'enables the user to check for viruses' do
      visit '/file_uploader/upload'

      within 'form' do
        attach_file 'test_server_file_upload[uploaded_file]', fixture_file('file_uploader/file.bin').path
        check 'test_server_file_upload[virus_scan]'
      end

      click_button 'upload'

      expect(page).to have_content 'Virus ID'
    end

    it 'enables the user to calculate check sums' do
      visit '/file_uploader/upload'

      within 'form' do
        attach_file 'test_server_file_upload[uploaded_file]', fixture_file('file_uploader/file.bin').path
        check 'test_server_file_upload[checksum_calculation]'
      end

      click_button 'upload'

      expect(page).to have_content 'MD5'
      expect(page).to have_content 'SHA256'
    end

    it 'enables the user to detect file type' do
      visit '/file_uploader/upload'

      within 'form' do
        attach_file 'test_server_file_upload[uploaded_file]', fixture_file('file_uploader/file.bin').path
        check 'test_server_file_upload[filetype_detection]'
      end

      click_button 'upload'

      expect(page).to have_content 'Filetype'
    end
  end
end
