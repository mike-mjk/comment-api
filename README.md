# Time Traveling Message App Part 2

Thanks for the opportunity to extend this project with a backend built with Ruby on Rails, GraphQL, PostgreSQL!

## What's cool about this?

### It's built with a number of new technologies for me

GraphQL and Apollo are slick! It was really fun to use these for the first time. I used GraphQL and Apollo for all of my queries and mutations. I learned a lot about working with these techs: Basic queries and mutations, refetching queries, compose, and general Apollo setup.

The backend for this project is built Ruby on Rails, PostgreSQL and Ruby's GraphQL. I learned a lot about Ruby and using ActiveRecord. And I learned about using SQL databases and structuring tables for one to many relationships, and many to many relationships. 

At one point, editing a message caused it to move to the bottom of the message thread. This was fixed by adding this line:

default_scope -> { order(:created_at) }

At another point, a user wasn't able to delete a message that had likes associated with it. This was caused by the message having a foreign key associated with it. It was fixed by adding this line to the message model: 

has_many :likes, dependent: :destroy


### Attention to detail.

This is relatively simple comment app but it includes some attention to detail that makes it really cool.

1. New messages will be visible as they are added. It scrolls to bottom. I initially used componentDidUpdate for this but that caused a bug in which like or edit or delete caused the scroll to bottom behavior as well. This was fixed by using prevProps and comparing the length of the messages array.

2. If you enter a username but don't submit it before submitting a message, the app will pull it in for you. This is much less annoying than being told you must enter a username. It's sitting right there, let's just grab it and use it. Importantly, it won't overwrite an existing username in the case where a name has been submitted and there is also one in the input field.

3. The like button functions based off of "current user". So it becomes an unlike button if the user has already liked. I think this is better than just being able to like an unlimited number of times.

4. If you go to edit a message and cancel the changes you've made, the canceled changes will not persist if you go to edit again. 

5. If you edit a message to blank, it runs the delete message function. Rather than just have a blank message sitting in the thread. In a production app, you would want to confirm the user wants to delete, of course.

6. The cursor moves to the message input after submitting a name. Nice!

7. Uh, messages travel through time, duh!