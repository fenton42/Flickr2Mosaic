require "spec_helper"

describe Flickr2Mosaic do
  it "has a version number" do
    expect(Flickr2Mosaic::VERSION).not_to be nil
  end

  it "provides a command line tool that is executable" do
    expect(File.stat("./exe/flickr2mosaic").executable?).to be_truthy
  end

  it "should be able to call the CLI via it's class" do
    expect{CLI.start}.to_not raise_error
  end

  it "should have a nice options parser in its own class" do
    expect{Parser.parse %w(--name Hansi)}.not_to raise_error
  end
end
