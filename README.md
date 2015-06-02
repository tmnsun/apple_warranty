apple_warranty is a Ruby library  with simple task in mind: get warranty info by Apple device serial number

Installation
---

In Bundler:
```ruby
gem 'apple_warranty'
```

Otherwise:
```bash
[sudo|rvm] gem install apple_warranty
```

Usage
---

```ruby
apple_warranty_scraper = AppleWarranty::Scraper.new

if apple_warranty_scraper.get_data(imei) # true on success
  apple_warranty_scraper.expired? # true/false
  apple_warranty_scraper.expired_at # nil or expired date
else # false if it cant fetch data from apple site
  apple_warranty_scraper.errors # errors array
end
```

Contributing
---

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.

Copyright
---

Copyright (c) 2015 Andrey Filippov. See LICENSE.txt for
further details.
