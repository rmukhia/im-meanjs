### im-meanjs

This is a docker **im**age of **MEAN.JS**, hence the name im-meanjs.
The main goal of this image is to provide an easy way to try out developing MEAN.JS applications.

Have fun using **I** a**m** **MEAN.JS**.

Visit dockerhub repository [rmukhia/im-meanjs][docker hub].
Visit github repository [rmukhia/im-meanjs][git hub]

##### Run

```bash
~$ docker pull rmukhia/im-meanjs
```

Pull im-meanjs from _dockerhub_.

```bash
~$ docker run -i -t -p 3000:3000 -p 35729:35729 -v $('pwd'):/home/dev/projects rmukhia/im-meanjs bash
```

Create a docker _container_.
* ```-i``` interactive
* ```-t``` attach to terminal
* ```-p 3000:3000``` map the host port 3000 to the container 3000 port
* ```-p 35729:35729``` map the host port 35729 to the container's 35729 port; this is required for [livereload.js][livereload]
* ```-v $('pwd'):/home/dev/projects``` mount the host's present working directory to container's /home/dev/projects directory
* ```rmukhia/im-meanjs``` image name
* ```bash``` open an interactive shell

If you want to make mongodb database persistent, host db directory should be mounted to container's /data/db directory by adding an option ```-v ~/db:/data/db```.

###### Start mongod

Inside the container;

```bash
~$ mongod --config ~/config/mongod.conf
```
Start mongod server

```bash
~$ cat ~/logs/mongod.log
```
Check if mongod is running an a deamon.

~/config/mongod.conf is a mongod configuration file, which can be edited.

###### Create a new MEAN.JS application.

Inside the container;

```bash
$ cd projects
```
Change the present working directory to mounted /home/dev/projects.

```bash
projects$ mkdir myapp && cd myapp
``` 
Create a new MEAN.JS application directory and change the present working directory.

```bash
projects$ yo meanjs
```
Use yomean to generate a MEAN.JS application. Create a new project myapp in myapp folder.
This will take some time.

```bash
myapp$ grunt
```
Start MEAN.JS application.

###### View and Edit 

From any browser of the host, view the MEAN.JS application

http://localhost:3000

Edit files of the MEAN.JS application from the host directory which you have mounted to the container using your favourite editor or IDE.

##### Reopen MEAN.JS application

After starting a new container start mongod, change the present working directory to the application directory and start grunt.

##### Features

im-meanjs is debian based and has the following features:

* Node.js and mongodb-org-server pre-installed,
* yo, grunt and generator-meanjs@0.1.12  pre-installed,
* non root dev user pre-created, login in as dev,
* global npm packages installed under /home/dev/.npm_global,
* configurable ~/config/mongod.conf,
* mount projects from host in /home/dev/projects,
* turn on, turn off presistent database by optionally mounting the container's /data/db directory

 
[docker hub]: https://hub.docker.com/add/automated-build/github/orgs/?namespace=rmukhia
[git hub]: https://github.com/rmukhia/im-meanjs
[livereload]: https://www.npmjs.com/package/livereload
