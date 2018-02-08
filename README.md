#Introduction

----
> The most difficult issues that I faced when completing this assignment was
  having to decide what sacrifices I wanted to make in terms of number HTTP
  requests to make to the Github Jobs API and how I wanted to organize parts of
  my code. Due to the desired deliverables, there was no extremely efficient way
  to parse through and transform the data in a necessary manner to get the desired
  output. One way or another, the runtime of the entire program would be O(n^2).
  Also, I wanted to not use any frameworks or tools outside of the Ruby stdlib
  which brought along it's own set of challenges after being so accustomed to
  being able to use all of the tools available within Rails. Ultimately, a series
  of assumptions had to be made in order to make the scope manageable for the
  assignment's time window including what languages to parse amongst others.

#Installation

----
> These instructions assume you are operating a Mac/Linux machine and have
  brew/linuxbrew installed as a package manager

> To install ruby, run the following command via the command line

 ``brew install rbenv``

> Upon completion of the previous command, run the following command via the
  command line

 ``rbenv init``

> Next, run this command via the command line to install

 ``rbenv install 2.4.2``

> Once installation is complete, run the following to ensure the desired version
  of ruby is globally declared

 ``rbenv global 2.4.2``

#Run the program

----
> Once the installation process is complete, cd into the directory the server.rb
  file exists ie wherever you've cloned the project and run:

 ``ruby server.rb``

> Now, go to localhost:8080 in your browser to see the program output.

> To kill the server/exit the program, be sure to ctrl + c the process from the
  command line ;)
