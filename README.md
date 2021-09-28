# Odin-Facebook (OdinSocial)
This project's aim was to create a social media site similar to Facebook (hence the name). It needed to have the basic functions of Facebook (e.g. Friends & Friend Requests) and capabilities typical to social media sites in general (i.e. users can interact with each other). Live on Heroku.

This project was made using Rails 6.1 with Ruby version 3.0. Styling is done using Bulma. AWS S3 for storing user avatars. Unit tests (TDD) for the models written using Minitest. 

Please refer to the Gemfile for complete information on the dependencies.

## Notes about discussion.md (feel free to skip)
A discussion.md will be made (if it's not already present) to talk about my journey thus far with Rails in the context of this project. It will also outline any issues, solutions and decisions made when making this app, alongside resources used to resolve issues or learn about additional ideas (whether used or not). That file may be relevant to you if you are looking to make a similar project, or if you are also doing The Odin Project or for some other reason.

## How to run (local)
To run this project in your development environment:
1. Clone this repo with `git clone git@github.com:qamk/odin-facebook.git`
2. Run bundler with `bundle install` to install the gems located in the Gemfile
3. Run `bin/rails db:migrate` to run the migrations
4. Start the server with `bin/rails server`, which will be at *localhost:3000*

For the model tests run `bin/rails test test/models/`. Some tests use *fixtures* which you will find under `test/fixtures`. Info on what they are will be in the discussion (you can also check the rails testing documentation, which explains them well).

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
For a list of resources please see discussion.md

## Final comment
This project was quite enjoyable, getting the core functionality, thinking about the data architecture and writing unit tests using TDD were relatively easy at this point. However, things like the interface, getting acquainted with ActiveStorage, writing a good (even if simple) service and generally resolving unexpected issues were not as familiar. This was a great mixture of applying familiar skills and extending my own skillset in one project!