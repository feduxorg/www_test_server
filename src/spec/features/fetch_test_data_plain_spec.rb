# encoding: utf-8
require 'spec_helper'

describe 'Fetch plain data' do
  it 'downloads the data' do
    visit('/string/plain')

    expect(page.status_code).to eq 200
    expect(page).to have_content('Plain Data')
  end

  it 'downloads the data with multiplier' do
    visit('/string/plain?count=10')

    expect(page.status_code).to eq 200
    expect(page.source.split(/\n/).size).to eq 10
  end

  it 'prevents caching by default' do
    visit('/string/plain')

    expect(page.status_code).to eq 200
    expect(page.response_headers).to be_key('Cache-Control')
    expect(page.response_headers['Cache-Control']).to include('no-cache')
  end

  it 'sets everything' do
    visit('/string/plain?expires=500')

    expect(page.status_code).to eq 200
    expect(page.response_headers).to be_key('Cache-Control')
    expect(page.response_headers['Cache-Control']).to include('must-revalidate')
    expect(page.response_headers['Cache-Control']).to include('max-age=500')
  end

  it 'serves eicar test string to check if virus scanners find that string' do
    eicar = [ 'X', '5', 'O', '!', 'P', '%', '@', 'A', 'P', '[', '4', "\\", 'P',
              'Z', 'X', '5', '4', '(', 'P', '^', ')', '7', 'C', 'C', ')', '7',
              '}', '$', 'E', 'I', 'C', 'A', 'R', '-', 'S', 'T', 'A', 'N', 'D',
              'A', 'R', 'D', '-', 'A', 'N', 'T', 'I', 'V', 'I', 'R', 'U', 'S',
              '-', 'T', 'E', 'S', 'T', '-', 'F', 'I', 'L', 'E', '!', '$', 'H',
              '+', 'H', '*' ]

    visit('/string/eicar')
    expect(page.status_code).to eq 200
    expect(page).to have_content(eicar.join)
  end

  it 'supports long running requests' do
    Timeout.timeout(3) do
      visit('/string/sleep?count=2')
    end

    expect(page.status_code).to eq 200
    expect(page).to have_content('Plain Data')
  end

  it 'supports random string' do
    visit('/string/random?count=2')

    expect(page.status_code).to eq 200
    expect(page.source.size).to eq 2
  end

  it 'supports base64 encoding' do
    visit('/string/plain?base64=on')

    expect(page.status_code).to eq 200
    expect(Base64.decode64(page.source)).to include 'Plain Data'
  end

  it 'supports base64 stric encoding' do
    visit('/string/plain?base64_strict=on')

    expect(page.status_code).to eq 200
    expect(Base64.strict_decode64(page.source)).to include 'Plain Data'
  end
end
