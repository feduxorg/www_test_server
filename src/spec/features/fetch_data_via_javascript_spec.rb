# encoding: utf-8
require 'spec_helper'

describe 'Fetch data via javascript', :js do
  context '/generator/xhr' do
    it 'submits requests to url' do
      url = '/generator/xhr'
      visit url

      within '#form' do
        fill_in 'url', :with => url
        fill_in 'count', :with => 1
      end


      click_button('start')

      first '.ts-result-row'

      expect(page).to have_content(url)
    end

    #it 'supports opening a new page based on given values' do
    #  url = '/generator/xhr'
    #  visit '/generator/xhr'

    #  within '#form' do
    #    fill_in 'url', :with => url
    #    fill_in 'count', :with => 1
    #    fill_in 'timeout', :with => 100
    #    find('#repeat').trigger('click')
    #  end

    #  click_link('clone')

    #  within_window '' do
    #    expect(find('#url').value).to eq url
    #    expect(find('#count').value).to eq '1'
    #    expect(find('#timeout').value).to eq '100'
    #    expect(find('#repeat').checked?).to be true
    #  end
    #end
  end
end
