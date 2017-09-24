Text Analyser
======

Text Analyser is a Redis-backed application that takes users input from the command line, analyse the content and save statistics in redis.
User's input can be anything which user enters from the terminal once application is started.

It is comprised of three parts:

  * A Ruby library for analysing sentences
  * A Ruby library for generating stats
  * A TCP server to shows stats.

TextAnalyser back end saves content in redis while the front end displays the content on the UI(/stats endpoint)in a json format. TextAnalyser works with Ruby 2.4.2


Overview
--------

TextAnalyser supports concurrency and allow multiple users to communite to same port. It allows options to user to set host and port for redis and TCP server other wise default port will be used.

```
Options:
    -T, --tcp [PORT]                 Run TCP Server
    -H, --thost [HOST]               Run TCP server on specified host
    -p, --rport [PORT]               Run Redis Server (Make sure redis-server is running on the port specified)
    -r, --rhost [HOST]               Run Redis server on specified host
    -h, --help                       Prints this help
    -v, --version                    Show version

```
Stats are generated based on the content saved in Redis so one user can see the content for all other users. Two redis servers running on seperate ports does not share the content.

Default port for TCP is 8080 while for Redis it is 5555 but it is configurable using the options above


Dependencies
------------

TextAnalyser is dependant on Redis-Server, so it requires redis application running before starting text_analyser. Otherwise it notifies user to start redis server.

Port must be open for TCP server so that HTTP access will be granted as well


Usage
------

To run the application, you just need to enter this command bin/text_analyser [OPTIONS] on your terminal and it will let you start entering sentence and access HTTP page as well.

Development
-----------

After checking out the repo, run bin/setup to install dependencies. Then, run rspec to run the tests. You can also run bin/text_analyser for an interactive prompt that will allow you to experiment.

Author
------

AtharNoor :: atharnoor2@gmail.com
