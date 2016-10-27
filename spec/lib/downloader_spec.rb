require 'spec_helper'
describe Flickr2Mosaic::Downloader do

  #just for tdd: make sure the class is there
  it 'should be able to initialize the downloader' do
    expect{subject.class.new}.not_to raise_error
  end

  it 'should be able to search for a tag at flickr and to return a url' do
    VCR.use_cassette(:downloader_download) do
      urls = Flickr2Mosaic::Processing.new.fetch_urls
      downloader = Flickr2Mosaic::Downloader.new
      expect{downloader.download(urls.first)}.not_to raise_error
    end
  end

  it 'should be able to get a file name from a flickr url' do
    url = 'https://farm8.staticflickr.com/7306/27418130722_7791215f19_b.jpg'
    downloader = Flickr2Mosaic::Downloader.new
    expect(downloader.send(:filename_from_url,url)).to be == '27418130722_7791215f19_b.jpg'
  end
end

