# easy-ansible-test
This demonstrates a quick Docker Compose set up to get up an ansible host and 3 targets.  Just a demo.  It's based off a hack used 
in [Mumshad Mannambeth's Udemy course on Advanced Ansible](https://www.udemy.com/learn-ansible-advanced/learn/v4/overview).  Mumshad has a Docker image that didn't quite work for me, so I "fixed it" with a
couple of Dockerfiles and setting up Docker Compose to use them.

---
##### Quick Warning

This is a toy install and does a number of things you'd never want to do on a production install. It uses passwords (this is from Mumshad's image), and I've disabled host key checking so that ansible can immediately talk to its targets; this is also *not* best practice. You should only use this configuration on your laptop or local system, making sure that the outside world cannot access it. But it should be fine for learning ansible w/o using too much memory or other resources.

---
### How To Use This

Using this is pretty simple, assuming you've installed Docker and Docker Compose (you get Docker Compose automatically on the Mac and Windows; on Linux it's an additional install). Once you've done that:

1) Download this repo either as an archive or via git clone.

2) cd into the created directory.

3) Just do the command 
````
docker-compose up -d
````

To log into the ansible host, use the ssh command, changing to port to 2222:
````
ssh -p 2222 root@localhost
````

This will get you into the ansible container. The network will already be set up using Docker's internal DNS and networking, and you can already ping the the target hosts w/o any additional set up:

````
My-Mac:easy-ansible-test $ docker-compose up -d
Creating network "easyansibletest_default" with the default driver
Creating easyansibletest_target2_1
Creating easyansibletest_target1_1
Creating easyansibletest_target3_1
Creating easyansibletest_ansible_1
My-Mac:easy-ansible-test $ ssh -p 2222 root@localhost
root@localhost's password:
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.9.87-linuxkit-aufs x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

root@87957fe89f01:~# ansible -m ping all
target3 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
target1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
target2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}

````


To bring down the containers and free up their resources, just do:
````
docker-compose down
````





