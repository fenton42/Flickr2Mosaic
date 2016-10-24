# Flickr2Mosaic

Your mission, should you choose to accept it
============================================

Write a Ruby command line application that

* accepts a list of search keywords as arguments
* queries the Flickr API for the top-rated image for each keyword
* downloads the results
* crops them rectangularly
* assembles a collage grid from ten images and
* writes the result to a user-supplied filename
* host your code repository on github or bitbucket

If given less than ten keywords, or if any keyword fails to
result in a match, retrieve random words from a dictionary
source such as `/usr/share/dict/words`. Repeat as necessary
until you have gathered ten images.

Be careful and conservative in your handling of files and
other IO. Bonus points for wrapping the application in a
Gem. Please include a README with instructions on how to
install and run your application.

Hint: You're free to use any existing Gem which helps you to
get the challenge done.


## Installation

Make sure to have some kind of ImageMagick or GraphicsMagick installed.
Assuming you are using MacOSX, please perform a
``` brew install imagemagick ```

Add this line to your application's Gemfile:

```ruby
gem 'Flickr2Mosaic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Flickr2Mosaic

## Usage

This GEM is mainly to be used as part of a Command Line Tool to solve the above given task.

Idea: flickr2mosaic --tags=sports,crime,snow,dog,cat,clouds,light,white,black,winter --layout=

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/Flickr2Mosaic.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

