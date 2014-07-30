HireEZ v2 [codename: brutus]
=========
Doing heavy lifting in the land of government hiring.<br />
<img src="http://www.kansassampler.org/siteassets/brutis3.jpg" /><br /><br />

This application supports ruby 2.0+ and we recommend using a ruby version manager like [rvm](http://rvm.io/) or rbenv(http://rbenv.org/).

## How To Get Started
  - Clone repo (`git clone git@github.com:18f/brutus.git`)
  - Install the bundle (`bundle install`)
  - Create local config files: `cd config`
    - `cp application.example.yml application.yml`
    - `cp database.example.yml database.yml`
    - `cp newrelic.yml.example newrelic.yml`
  - Register your application
    - with [MyUSA](http://my.usa.gov) (Redirect URI: [host]/auth/myusa/callback)
    - OR for loal dev register with QA server [MyUSA](http://qa.my.usa.gov) (Redirect URI: http://localhost:3000/auth/myusa/callback)
  - edit application.yaml
    - MYUSA_OAUTH_PROVIDER_KEY should be your Auth Client ID from MyUSA
    - MYUSA_OAUTH_PROVIDER_SECRET should be your Auth Client Secret from MyUSA
    - if you are using MyUSA QA, then set MYUSA_HOME: https://qa.my.usa.gov
  - Install [redis](http://redis.io/topics/quickstart) and [memcached](http://cloudbur.st/evan/memcached/files/README.html).  Redis will attempt to run automatically at startup in development.
  - rake db:setup
  - Fire up rails! (`rails s`)



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
