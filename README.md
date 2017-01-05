# Leiestedet

## Introduction

Leiestedet is a web service that aims to make it easier for people to loan out
clothes in return for a small sum of money online. The website has an emphasis
on simplicity, and aims to make the process as easy and painless as possible.

## Details

### Feature spec

The website will feature a lot of the same features as [finn](https://finn.no);
the user posts a listing, and other users can contact the user with the contact
information the poster provided. All transactions are done in person, removing
the need for transactions online. This greatly reduces costs by requiring the
developer to do far less, and the users are less susceptible to being scammed.

We also have Google maps integration to make it easier for our users to find
one-another when they are going to rent a piece of clothing. This is done by
having a form input with GMaps autocomplete on the registration page, and saving
the unique ID for the place they select and rendering a map on the profile#show
and listing#show pages.

Another thing we put a lot of work into is the image uploading. To reduce the
load times when using the page, we generate a 200x200 thumbnail version of the
images you upload, so they can be loaded into the page without having to load
the full resolution images. This greatly reduces the avg page load time, only
costing a bit more processing power when the user creates a new listing with
images, and some more storage space, although that's a sacrifice we're willing
to make.

All the images will also be downscaled if they are too big (1280x720 is max
resolution for an image, all images will retain their original aspect ration
when downscaled), and all images are converted to JPEG.

### Further documentation

As of right now there is no way to see the further documentation unless you ask
us for it over email or another communication platform, but we will eventually
upload it to fullstck.io under a portfolio page, which at the time of writing is
planned to be released before the summer 2017.

### Testing

All aspects of the website will be tested with rspec; a testing framework for
ruby. Along with this we will also do some QA testing with several people, to
ensure the website works as intended, and this also helps to point out flaws in
the design.

To see all of the tests look in the 'spec/' directory.

### Contribution

To contribute to the website, simply create a fork, do your changes there, and
create a PR. We will review it as soon as we have time, and will get back to you
with feedback.

We have no strict guidelines on how your commit messages, however the code
should follow our "ways". I.e. you should use 2 spaces for indentation, comment
where it is not clear what the code does, and you should use descriptive
variable and function names.

### Technical details

* Web framework: Ruby on Rails 5
* Authentication library: [devise](https://github.com/plataformatec/devise)
* Front-end framework: [materializecss](http://materializecss.com)
* Database: PostgreSQL
* Testing framework: [rspec](http://rspec.info/)

### Color scheme

For the time being the color scheme will be black and white (of course with
variations of grey in-between).

## License

Leiestedet is released under the GNU AGPL-v3
