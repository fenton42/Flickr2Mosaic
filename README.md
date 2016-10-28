# flickr2mosaic

The mission
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

Make sure to have ruby-2.3 or better!

  I fear this tool works only on *UX operating systems due to the ImageMagick/GraphicsMagick requirement.
  
Make sure to have some kind of ImageMagick or GraphicsMagick installed.
Assuming you are using MacOSX, please perform a
``` brew install imagemagick ```
Using Linux you should use the package manager of your choice

Add this line to your application's Gemfile:

```ruby
gem 'fenton42/Flickr2Mosaic'
```

And then execute:

    $ bundle

You may also install the GEM manually:

  1. Fetch the GEM
```ruby
git clone https://github.com/fenton42/Flickr2Mosaic.git
```
  2. Build the gem:
```ruby
  cd Flickr2Mosaic && bundle install && gem build flickr2mosaic.gemspec
```
  3.Install the GEM (change the version number accordingly)
```ruby
sudo gem install flickr2mosaic-0.1.3.gem
```
## Usage

This GEM is mainly to be used as part of a Command Line Tool to solve the above given task.

  flickr2mosaic --tags=sports,crime,snow,dog,cat,clouds,light,white,black,winter --output=./myfile.png --tmpdir=/tmp/

It definitively needs a Flickr-API-Key to work.
You may provide the key via an environment variable or some secret files: (see filenames below)

     api_key= ENV[:FLICKR_API_KEY.to_s] || fetch_key_from_file('~/.flickr2mosaic/api_key.txt') 
     secret_key = ENV[:FLICKR_SECRET_KEY.to_s] || fetch_key_from_file('~/.flickr2mosaic/secret_key.txt')
     

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/flickr2mosaic.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

