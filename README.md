# travlendar

#### Deployement repository for travlendar app, a SE2 project

#### Production website https://travlendarplus.herokuapp.com


## Getting started
As a prerequisite, you should have installed a version of `Ruby > 2.0`.  
How to install ruby: https://www.ruby-lang.org/en/documentation/installation/

Also, a running `PostgreSQL` server.  
How to install PostgreSQL: https://www.postgresql.org/download/

The best way to install gems for rails is the `bundler` gem.  


```
$ gem install bundler
```

To get started with the app, clone this repo:

```
$ git clone https://github.com/andreicap/travlendar.git
$ cd travlendar
```

After that, you have to install all the needed gems:

```
$ bundle install
```

Next, create and migrate the database:

```
$ rails db:create db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rspec 
```

For a more detailed test output, run:

```
$ rspec spec --format documentation
``` 

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

Access http://localhost:3000 to enjoy the website.