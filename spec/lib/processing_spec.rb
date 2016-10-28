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
      VCR.use_cassette(:perform) do 
        expect{ @processing.perform }.not_to raise_error
      end
    end

    # This does not work any more: I'm mocking download_all so that no filenames
    # are returned but afterwards processing tries to resize the images... 
    # it 'perform should trigger the download' do
    #   VCR.use_cassette(:processing_download_all) do
    #     expect_any_instance_of(Flickr2Mosaic::Processing).to receive(:download_all)
    #     Flickr2Mosaic::CLI.start
    #   end
    # end

    it 'should be able to fetch 10 different image urls for 10 tags from the downloader' do

      VCR.use_cassette(:processing_fetch_urls) do
        urls = @processing.fetch_urls
        expect(urls.uniq.count).to be == 10
        expect(urls.first).to match(/^http/)
      end
    end

    it 'should be able to fetch 10 different images for 10 tags from the downloader' do
      VCR.use_cassette(:processing_download_10_different) do
        FileUtils.rm_rf(Dir.glob(TMP + "/*.jpg"))
        expect(Dir.entries(TMP).select{|f| f =~ /jpg$/ }.count).to be == 0
        @processing.fetch_urls
        @processing.download_all
        expect(Dir.entries(TMP).select{|f| f =~ /jpg$/ }.count).to be == 10
      end
    end

    it 'should trigger the mosaic creation' do
      VCR.use_cassette(:processing_create_mosaic) do
        expect_any_instance_of(Flickr2Mosaic::Processing).to receive(:create_mosaic)
        Flickr2Mosaic::CLI.start
      end
    end

    it 'should perform a cleanup of the temp files' do
      VCR.use_cassette(:processing_cleanup_test) do
        @processing.fetch_urls
        @processing.download_all
        @processing.filenames.each do |filename|
          expect( File.exists? filename ).to be_truthy
        end
        @processing.cleanup
        @processing.filenames.each do |filename|
          expect( File.exists? filename ).to be_falsey
        end
      end
    end


  end
end

