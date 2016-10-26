require 'spec_helper'
describe Flickr2Mosaic::FlickrSearch do

  #just for tdd: make sure the class is there
  it 'should be able to initialize the flickr search engine class' do
    expect{subject.class.new}.not_to raise_error
  end

  it 'should be able to search for a tag at flickr and to return a url' do
    VCR.use_cassette "search_tag_computer" do
      expect(subject.get_url_by_search_tag('computer')).to match( /^http/ )
    end
  end

  it 'should be able to search for a tag at flickr and to return nil if nothing found' do
    VCR.use_cassette "search_tag_gobbledegook" do
      expect(subject.get_url_by_search_tag('dfjldksjfldsfjlksadjf')).to be_nil
    end
  end
  
  it 'should be able to search for a tag list and skip tags where nothing can be found' do
    VCR.use_cassette "many_search_tags" do
      expect(subject.get_urls_by_tags(['computer','red','dfjldksjfldsfjlksadjf']).count).to be == 2
    end
  end

end

