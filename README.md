# Steven

'Even Steven'

Given a list of files and their sizes, make a naive attempt to split them
into buckets based on their size

## Installation

Add this line to your application's Gemfile:

    gem 'steven'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install steven

## Usage

    all_files = []
    all_files << Steven::SpecFile.new("models/admin_spec.rb", 200)
    all_files << Steven::SpecFile.new("models/membeship_spec.rb", 800)
    all_files << Steven::SpecFile.new("models/user_spec.rb", 1200)
    all_files << Steven::SpecFile.new("request/admin_spec.rb", 300)
    all_files << Steven::SpecFile.new("request/membeship_spec.rb", 700)
    all_files << Steven::SpecFile.new("request/wedding_spec.rb", 900)
    all_files << Steven::SpecFile.new("utils/date_utils.rb", 100)
    all_files << Steven::SpecFile.new("utils/form_utils.rb", 1000)
    all_files << Steven::SpecFile.new("utils/email_utils.rb", 1200)
    bucketer = Steven::FileBucketer.new(all_files)
    bucketer.bucket_them(2)

    bucketer.get_bucket(0).get_total_size
    # 3400
    bucketer.get_bucket(1).get_total_size
    # 3000

    bucketer.get_bucket(0).files.map(&:filename)
    # ["utils/email_utils.rb", "utils/form_utils.rb", "models/membeship_spec.rb", "request/admin_spec.rb", "utils/date_utils.rb"]


TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/gmccreight/steven/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
