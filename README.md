<h1>Rails Pinning-app</h1>

<ul>
   <li>Rails pinning-app is a practice web site that I have developed to sharpen my Ruby and Rails skills. The application mimics key features of famous social networking sites such as Twitter, LinkedIn, Pinterest etc. Here is a list of features that this app offers.
   <ul>
      <li>User registration and logging in/logging out functionality.</li>
      <li>Posting new pins by uploading images. Updating existing pins is also possible.</li>
      <li>Creating boards for various pin categories</li>
      <li>Follow other users and also allow other users to follow you.</li>      
   </ul>
   </li>
   <li>Initial app setup provided by <a href="https://github.com/skillcrush/rails-pinning-app">Skillcrush</a></li>
   <li>Heavy contribution by Nauman Sheikh.</li>
</ul>

<h2>Platform</h2>

<h3>Languages Used</h3>

<ul>
   <li><a href="https://www.ruby-lang.org/en/">Ruby</a></li>
   <li><a href="https://www.javascript.com/">JavaScript</a></li>
   <li><a href="https://www.w3schools.com/html/html5_intro.asp">HTML5</a></li>
</ul>
<h2>Notable Libraries</h2>
<ul>
   <li><a href="http://rubyonrails.org/">Rails 4.2.0</a></li>
</ul>
<h2>Server Platform</h2>
<ul>
   <li>Ruby 2.3.3</li>
   <li>PostgreSQL 9+</li>
</ul>
<h2>External Services</h2>
<ul>
   <li><a href="https://aws.amazon.com/">Amazon AWS</a></li>
</ul>
<h2>Development</h2>
<br/>
To run this app you'll likely need a rough understanding of how Rails apps work these days. You will also need:
<br/>
<ul>
   <li>PostgreSQL 9.4+</li>
    <li><a href="https://aws.amazon.com/">Amazon AWS</a></li>
    <li><a href="http://puma.io/">Puma Server</a></li>
    <li><a href="https://github.com/thoughtbot/paperclip/wiki">Paperclip gem</a></li>
</ul>

First, clone the repo (ideally from your own fork):

<code>git clone git@github.com:nomi474/pinterest-app.git</code>

Then move into that directory install the gems using Bundler:

<code>bundle install</code>

Next you will need to configure your database.yml file. 

<code>cp config/database.example.yml config/database.yml</code>

You'll likely need to edit those settings for your local machine.

<p>Now you need to create and set up the database:</p>
<p><code>rake db:setup</code></p>

<blockquote>
<p>In particular, you may want to check your username in psql with command: <code>$ psql</code> which should bring up your psql command line <code>username=#</code>. You can update your <code>config/database.yml</code> accordingly. Also,you may <a href="http://www.postgresql.org/docs/9.0/static/sql-createdatabase.html">create new PG database</a>.</p>
</blockquote>

<h3>S3 is used in development</h3>

Due to the plugins used for handling uploads, S3 support is required even in development. It's not ideal, but you'll need to fill out those S3 keys in your .env file with details for your S3 bucket.

In both development and production you will need to configure <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html">CORS</a> correctly on Amazon. 

<h3>Testing with RSpec</h3>
To start up the automated testing you might first need to create and migrate the test DB:

<code>RAILS_ENV=test rake db:create</code><br/>
<code>RAILS_ENV=test rake db:migrate</code>

Then you can start up the automated tests with:

rake spec

