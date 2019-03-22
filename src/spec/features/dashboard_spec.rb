# encoding: utf-8
require 'spec_helper'

describe 'Dashboard', :js do
  context 'Overview test functions' do
    it 'lists links to all other test functions' do
      visit '/'
      expect(page).to have_selector 'div.ts-dashboard-section-body li a'
    end
  end
end
