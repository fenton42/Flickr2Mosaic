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
end

