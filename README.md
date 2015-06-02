AppleWarranty [![Code Climate](https://codeclimate.com/github/tmnsun/apple_warranty/badges/gpa.svg)](https://codeclimate.com/github/tmnsun/apple_warranty) [![Test Coverage](https://codeclimate.com/github/tmnsun/apple_warranty/badges/coverage.svg)](https://codeclimate.com/github/tmnsun/apple_warranty/coverage)
---

apple_warranty is a Ruby library  with simple task in mind: get warranty info by Apple device serial number

Installation
---

In Bundler:
```ruby
gem 'apple_warranty', git: "git://github.com/tmnsun/apple_warranty.git"
```

Usage
---

```ruby
warranty_scraper = AppleWarranty::Scraper.new

if warranty_scraper.get_data(imei) # true on success
  warranty_scraper.warranty_expired?  # true if expired
  warranty_scraper.warranty_active? # false if expired
  apple_warranty_scraper.warranty_expired_at # nil or expired date
else # false if cant fetch data from apple site or imei validation failed
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
