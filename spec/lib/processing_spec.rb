require 'spec_helper'
module Flickr2Mosaic
  describe Processing do

    TMP='./tmp'

    before(:all) do
      Dir.mkdir(TMP) unless Dir.exists? TMP
    end

    before(:each) do
      1.upto 10 do |num|
        fname=[TMP, num.to_s+".jpg"].join('/')
        File.delete(fname ) if File.exist? fname
      end
      @processing = Processing.new(tmpdir: TMP)
    end

    it 'should provide a perform method' do
      expect{ @processing.perform }.not_to raise_error
    end

    it 'should trigger the download' do
      expect_any_instance_of(Flickr2Mosaic::Processing).to receive(:download).and_return 10
      Flickr2Mosaic::CLI.start
    end

    it 'should be able to fetch 10 different images for 10 tags from the downloader' do
      expect(Dir.entries(TMP).select{|f| f =~ /jpg$/ }.count).to be == 0
      @processing.download
      expect(Dir.entries(TMP).select{|f| f =~ /jpg$/ }.count).to be == 10
    end

    it 'should trigger the mosaic creation' do
      expect_any_instance_of(Flickr2Mosaic::Processing).to receive(:create_mosaic)
      Flickr2Mosaic::CLI.start
    end

  end
end

