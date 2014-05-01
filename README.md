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


License
--

<p xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <a rel="license"
     href="http://creativecommons.org/publicdomain/zero/1.0/">
    <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" /></a>
  <br />
  To the extent possible under law,
  <a rel="dct:publisher"
     href="http://18f.gsa.gov">
    <span property="dct:title">18F</span></a>
  has waived all copyright and related or neighboring rights to
  <span property="dct:title">HireEZ v2</span>.
This work is published from:
<span property="vcard:Country" datatype="dct:ISO3166"
      content="US" about="http://18f.gsa.gov">
  United States</span>.
</p>
