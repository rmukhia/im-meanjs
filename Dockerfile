FROM debian
ENV TERM=xterm

# Update and install essential packages
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y curl build-essential git dos2unix ruby 

# Node.js and mongodb requirements
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -a && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv EA312927 && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Update again, and install Node.js and mongodb and sass gem. Create dev user. Set up mongodb log permissions and parameters.
RUN apt-get update && apt-get install -y nodejs mongodb-org-server && npm install -g npm && gem install sass && useradd -ms /bin/bash dev && mkdir -p /data/db && chown dev:dev /data/db

# Set up dev
USER dev
WORKDIR /home/dev
# Symlinks on mounted directories do not seem to work, include path to actual bower script to enable `yo meanjs` on mounted directory. 
ENV PATH=~/.npm-global/lib/node_modules/bower/bin/:~/.npm-global/bin:$PATH
# Create directories, set npm configurations, install bower, grunt, yo and generator-meanjs. Set bin-links to false so that npm works without symlinks in mounted directory.
RUN mkdir ~/.npm-global && mkdir ~/logs && npm config set prefix '~/.npm-global' && npm install -g bower grunt-cli yo generator-meanjs &&  mkdir ~/config && npm config set bin-links false && rm ~/.npm-global/bin/bower
COPY configurations/mongod.conf /home/dev/config/mongod.conf
