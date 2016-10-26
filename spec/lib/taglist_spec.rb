require 'spec_helper'
describe Flickr2Mosaic::Taglist do

  #just for tdd: make sure the class is there
  it 'should be able to initialize the downloader' do
    expect{subject.class.new}.not_to raise_error
  end

  it 'should be able to provide me with another tag from a file if asked to' do
    expect(subject.next).to be_kind_of String
  end
end

