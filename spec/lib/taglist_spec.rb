require 'spec_helper'
describe Flickr2Mosaic::Taglist do

  #just for tdd: make sure the class is there
  it 'should be able to initialize the taglist' do
    VCR.use_cassette "hotlist_20" do
      expect{subject.class.new}.not_to raise_error
      @taglist=Flickr2Mosaic::Taglist.new
      expect(@taglist.taglist).not_to be_empty
    end
  end

  it 'should be able to initialize the taglist from a given file' do
    @taglist=Flickr2Mosaic::Taglist.new(filename: 'spec/fixtures/taglist.txt')
    expect(@taglist.taglist).to eq %w(hans nase otto karl)
  end
  
  it 'should be able to initialize the taglist with own parameters that have precedence' do
    @taglist=Flickr2Mosaic::Taglist.new(own_tags: %w(fritz philip), filename: 'spec/fixtures/taglist.txt')
    expect(@taglist.own_tags).to eq %w(fritz philip)
    expect(@taglist.taglist).to eq %w(hans nase otto karl)
  end

  it 'should raise an exception if a _given_ file does not exist (no hotlist fallback)' do
    expect{Flickr2Mosaic::Taglist.new(filename: 'spec/fixtures/doesnotexist.txt')}.to raise_error(RuntimeError)
  end

  it 'should raise an exception if a file does not contain the correct format' do
    expect{Flickr2Mosaic::Taglist.new(filename: 'spec/fixtures/wrong_format.txt')}.to raise_error(TagListFormatError)
  end

  it 'should respect the limit parameter' do
    taglist=Flickr2Mosaic::Taglist.new(filename: 'spec/fixtures/taglist.txt', limit: 2)
    expect(taglist.taglist).to eq %w(hans nase)
  end

  it 'should return nil if there is no element left' do
    taglist=Flickr2Mosaic::Taglist.new(no_random: true,
                                       filename: 'spec/fixtures/taglist.txt', 
                                       limit: 2)
    expect(taglist.next).to eq "hans"
    expect(taglist.next).to eq "nase"
    expect(taglist.next).to be_nil
  end

  it 'should be able to provide me with another tag from a file if asked to' do
    VCR.use_cassette "hotlist_20" do
      @taglist=Flickr2Mosaic::Taglist.new
      expect(@taglist.next).to be_kind_of String
    end
  end

  it 'should be able to provide me with a list of tags from Flickr (hotlist)' do
    VCR.use_cassette "hotlist_20_query" do
      expect(subject.hotlist).to be_kind_of Array
      expect(subject.hotlist.count).to be == 20
    end
    VCR.use_cassette "hotlist_10" do
      expect(subject.hotlist(10).count).to be == 10
    end
  end
end

