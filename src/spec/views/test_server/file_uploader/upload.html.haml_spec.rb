# encoding: utf-8
require 'spec_helper'

describe "file_uploader/upload.html.haml" do
  context 'File Upload' do
    it 'shows a form to upload a file' do
      visit '/file_uploader'

      expect(page).to have_content 'File Uploader'
    end
  end
end
