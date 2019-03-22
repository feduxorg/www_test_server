# encoding: utf-8
require 'spec_helper'

describe "file_uploader/index.html.haml" do
  context 'Upload files' do
    it 'lists links to all other test functions' do
      visit '/file_uploader/'

      expect(page).to have_content 'Upload file'
    end
  end
end
