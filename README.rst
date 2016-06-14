*******************
Data-Crow Container
*******************

* Based on ``java:8-jdk``
* Docker image name: ``netresearch/data-crow``

Builds an docker image for Data-Crow

- http://www.datacrow.net/
- https://sourceforge.net/projects/datacrow/
- http://www.fosshub.com/Data-Crow.html

====================
Creating a new image
====================
run::

    $ make

=========================
Upload to docker registry
=========================
To push it onto the netresearch docker registry at ``couchi.nr:5001``,
do this::

    $ make push

=================
Running container
=================

docker-compose::

    docker-compose up -d

docker::

    docker run -ti -p 80:80 -p 9000:9000 -p 9001:9001 \
        netresearch/data-crow \
        java -Xmx512m -jar /src/dc-server/datacrow-server.jar -userdir:/src -webserverport:80

==========
References
==========

- http://linuxg.net/how-to-install-data-crow-4-0-1-on-ubuntu-debian-and-derivative-systems/

- https://github.com/cogniteev/docker-oracle-java/blob/master/oracle-java8/Dockerfile
- https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
- https://hub.docker.com/_/java/

- https://github.com/docker-library/openjdk/pull/48/commits/0f82de10e4aaa8b78d7f79cf725fd1fad1dc85e0
- https://github.com/docker-library/openjdk/issues/46
- https://github.com/docker-library/openjdk/issues/73
- http://stackoverflow.com/questions/30626136/cannot-load-font-in-jre-8
