Bloggy
======

Bloggy is a blogging engine so minimalistic, it doesn't even include a webframework.

You can use Bloggy with Sinatra like this:

    require 'rubygems'
    require 'sinatra'
    require 'bloggy'

    Bloggy.folder = File.join(File.dirname(__FILE__), 'posts')

    get '/' do
      @posts = Bloggy.all
      erb :index
    end

    get '/:slug' do
      @post = Bloggy.find(params[:slug])
      erb :show
    end
    
This will serve markdown files from the ./posts folder. The name of the markdown file must
contain a date, an may contain a slug, where the post is accessible

    2009-02-14.md
    2009-02-14-my-first-bloggy-post.md

The first line of the post is used as title. If there is no slug in the filename, the title
is parameterized and used. The markdown file can contain an optional author annotation like this:

    / Jonas Nicklas <jonas.nicklas@gmail.com

It must be the last line of the file.

In your view, you can do something like this:

    <% @posts.each do |post| %>
      <h1><%= post.title %><

      <p class="date"><%= post.published_at %></p>
      
      <%= @post.html %>
    <% end %>

There's also

    Bloggy.published

which will find only those posts with a date that is in the past.