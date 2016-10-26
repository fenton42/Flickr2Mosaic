require 'spec_helper'
describe Flickr2Mosaic::MosaicGenerator do
  #just for tdd: make sure the class is there
  it 'should be able to initialize the mosaic generator' do
    expect{subject.class.new}.not_to raise_error
  end
end

