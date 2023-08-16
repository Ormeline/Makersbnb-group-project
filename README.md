# MakersBnB Project Description

This is a clone of Airbnb built as part of week 6 of the Makers Academy 'MakersBnb' group project. The program is built in Ruby (using Sinatra and RSpec).

## Setup Instructions

* Clone repository
* Run `bundle install`

# Run the tests:
* rspec

# Run the server (better to do this in a separate terminal):
* rackup 
This will also allow you test in browser.
Once run in terminal, it will list the port. You then have to manually type http://localhost:9292. This will lead you to the login page of the app

### Features

- Users can log in
- Users can view spaces available with descriptions and price information
- If logged in, users can list their own space(s)
- Users can view the availability of a space
- Users can view booking requests for their spaces
- Users can book a space


#### Functionality to add

Unfortunately, due to time constraints, the following features could not be implemented fully:

- Users can sign up to MakersBnb
- Users can approve/decline booking requests for their spaces
- Users can edit/delete their spaces

## Tech Stack
- [Sinatra](http://sinatrarb.com) a web framework for apps written in Ruby.
- [Ruby](https://www.ruby-lang.org/en/) our programming language.
- [PostgreSQL](https://www.postgresql.org) an open source relational database.
- [PG](https://rubygems.org/gems/pg/versions/1.3) a Ruby interface for the PostgreSQL relational database mapping system.
- [Rack](https://github.com/rack/rack) a modular Ruby webserver interface.
- [Rake](https://github.com/ruby/rake) a centralised task runner.
- [Handlebars](https://handlebarsjs.com/) to render view templates.
- [Rspec](https://github.com/rspec/rspec) for testing.
- [Capybara](https://github.com/teamcapybara/capybara) for end-to-end testing.
- [Bcrypt](https://www.npmjs.com/package/bcrypt) for password encryption.
- [Rubocop](https://github.com/rubocop-hq/rubocop) for linting.


## Planning

## User Stories

A signed-up user can list a new space.
```
As a user
So I can let people know I have a space to rent
I would like to list a new space
```


Users can list multiple spaces.
```
As a user
So  can let people know I have a multiple space to rent
I would like to list more than one space
```

Users should be able to name their space, provide a short description of the space, and a price per night.
```
As a  user
So I can advertise my space
I would like to specify a name, description and price for my space
```

Users should be able to offer a range of dates where their space is available.
```
As a registered user
So I can advertise my space
I would like to specify the date the space is available for
```

A user can request to hire any space for one night, and this should be approved by the user that owns that space.
```
As a user
So that I can make a booking
I would like to request to hire a space for one night
```

```
As a registered user
So that I can confirm a booking
I would like to approve a users request to rent my space for one night
```

Until a user has confirmed a booking request, that space can still be booked for that night.
```
As a user
Until I have confirmed the booking
I would like other users to be able to book my space
```

