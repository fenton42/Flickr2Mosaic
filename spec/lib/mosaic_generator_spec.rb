require 'spec_helper'
describe Flickr2Mosaic::MosaicGenerator do
  let(:filenames){ (1.upto 10).map { "bla" } }
  #just for tdd: make sure the class is there
  it 'should be able to initialize the mosaic generator' do
    expect{Flickr2Mosaic::MosaicGenerator.new(:filenames => filenames)}.not_to raise_error
  end

  it 'should make sure that x-size and y-size per picture are correct' do
    mg = Flickr2Mosaic::MosaicGenerator.new(:filenames => filenames)
    expect( mg.column_width ).to be == 1280/4
    expect( mg.column_height ).to be == 960/3
  end
  
  it 'should be able to resize a picture so that it matches the desired field size' do
    FileUtils.cp( 'spec/fixtures/ruby.jpg', 'spec/fixtures/ruby_tmp.jpg' )
    expect{Flickr2Mosaic::MosaicGenerator.new(:filenames => filenames).send(:resize_picture,'spec/fixtures/ruby_tmp.jpg',1,1)}.not_to raise_error
    #FileUtils.rm( 'spec/fixtures/ruby_tmp.jpg' )
  end
  
  it 'should be able to check the given layout for correctness' do
    expect{Flickr2Mosaic::MosaicGenerator.new(:filenames => filenames).check_layout}.not_to raise_error
     layout = Flickr2Mosaic::MosaicGenerator.new(:filenames => filenames).check_layout
     expect(layout == { 
       1  => [2,1] ,
       2  => [1,1] ,
       3  => [1,1] ,
       4  => [1,1] ,
       5  => [1,1] ,
       6  => [1,1] ,
       7  => [1,2] ,
       8  => [1,1] ,
       9  => [1,1] ,
       10 => [1,1] }).to be_truthy
  end

  it 'should be able to create an image' do
    #test is too hard to write in this file. I'm going to use it in Processing
  end
end

