<h1>Rails Pinning-app</h1>

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

<h3>S3 is used in development</h3>

Due to the plugins used for handling uploads, S3 support is required even in development. It's not ideal, but you'll need to fill out those S3 keys in your .env file with details for your S3 bucket.

In both development and production you will need to configure <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html">CORS</a> correctly on Amazon. 

<h3>Testing with RSpec</h3>
To start up the automated testing you might first need to create and migrate the test DB:

RAILS_ENV=test rake db:create
RAILS_ENV=test rake db:migrate

Then you can start up the automated tests with:

rake spec

