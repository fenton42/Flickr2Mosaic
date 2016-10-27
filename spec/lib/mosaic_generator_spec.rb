require 'spec_helper'
describe Flickr2Mosaic::MosaicGenerator do
  #just for tdd: make sure the class is there
  it 'should be able to initialize the mosaic generator' do
    expect{Flickr2Mosaic::MosaicGenerator.new(:filenames => (1.upto 10))}.not_to raise_error
  end
  
  it 'should be able to resize a picture so that it matches the desired field size' do
    #TODO the test is too naive
    expect{Flickr2Mosaic::MosaicGenerator.new(:filenames => (1.upto 10)).resize_picture('filename',1, 2)}.not_to raise_error
  end
end

