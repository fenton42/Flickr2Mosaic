require 'spec_helper'
describe Flickr2Mosaic::Downloader do

  #just for tdd: make sure the class is there
  it 'should be able to initialize the downloader' do
    expect{subject.class.new}.not_to raise_error
  end
end

