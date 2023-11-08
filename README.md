# Odin-Facebook (OdinSocial)
This project's aim was to create a social media site similar to Facebook (hence the name). It needed to have the basic functions of Facebook (e.g. Friends & Friend Requests) and capabilities typical to social media sites in general (i.e. users can interact with each other). The previous live application link has been removed as (i) I deleted my free-tier AWS account and (ii) Heroku is no longer free.

This project was made using Rails 6.1 with Ruby version 3.0. Styling is done using Bulma. AWS S3 for storing user avatars*. Unit tests (TDD) for the models written using Minitest.

Please refer to the Gemfile for complete information on the dependencies.

## How to run (local)
To run this project in your development environment:
1. Clone this repo with `git clone git@github.com:qamk/odin-facebook.git`
2. Run bundler with `bundle install` to install the gems located in the Gemfile
3. Run `bin/rails db:migrate` to run the migrations
4. Start the server with `bin/rails server`, which will be at *localhost:3000*

For the model tests run `bin/rails test test/models/`. Some tests use *fixtures* which you will find under `test/fixtures`. You can check the rails testing documentation for information.

## Features: What can I do? 
So this is fairly simple to use. You will see the drop down on the top right that will connect you to the different parts of OdinSocial. You can:
- Send requests to other users
  - Can be done from your timeline with "Suggested" users
  - Can be done from the Users Index
- Respond to requests
  - Accept --> Become friends
  - Ignore --> Reject friendship
- Make posts
- Comment on posts
- Edit comments and posts
- Like (and un-like) comments or posts
- Upload an avatar
  - Note that it won't show what file you've selected

## Resources
The following were a great help:
- Designing a service
  - https://www.honeybadger.io/blog/refactor-ruby-rails-service-object/
- Validating Active Storage objects?
  - https://gist.github.com/lorenadl/a1eb26efdf545b4b2b9448086de3961d
  - I wound up creating a service instead, which is called in the controller (perhaps not optimal)
- Routing to something other than path/to/resource/:id
  - https://stackoverflow.com/questions/7735315/rails-route-to-username-instead-of-id
  - I did not use it, but it may be of use to you!
- Validate the uniqueness of two+ columns at the same time
  - https://stackoverflow.com/questions/34424154/rails-validate-uniqueness-of-two-columns-together
- If minitest fails to run
  - https://stackoverflow.com/questions/65479863/rails-6-1-ruby-3-0-0-tests-error-as-they-cannot-load-rexml


## Final comment
This project was quite enjoyable, getting the core functionality, thinking about the data architecture and writing unit tests using TDD were relatively easy at this point. However, things like the interface, getting acquainted with ActiveStorage, writing a good (even if simple) service and generally resolving unexpected issues were not as familiar. This was a great mixture of applying familiar skills and extending my own skillset in one project!

I will be reading Sandi Metz's *Practical Object Oriented Design* to learn how to best used Object Oriented Design (OOD) to make better, more adaptable code!

\* My free tier for AWS S3 has run its course so this will be terminated. The code will fall to using another storage method but this app will reach EoL soon.
