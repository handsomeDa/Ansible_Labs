# Ansible_Labs


## Requirements
- Linux base OS/VM
- Install Docker
- Install Docker-Compose

Or

- [Online Docker Labs (Skip Install Docker&Docker-Compose)](https://labs.play-with-docker.com/)



## Install Docker
Step 1: install basic libs
```
$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

Step 2: Update container.io. Otherwise, `package docker-ce-3:19.03.13-3.el7.x86_64 requires containerd.io >= 1.2.2-3, ...` errors
check latest version => https://mirrors.aliyun.com/docker-ce/linux/centos/8/x86_64/stable/Packages/
```
$ sudo dnf install -y --allowerasing https://mirrors.aliyun.com/docker-ce/linux/centos/8/x86_64/stable/Packages/containerd.io-1.3.7-3.1.el8.x86_64.rpm
```

Step 3: Install docker-CE
```
$ sudo yum install -y docker-ce
```

Step 4: start docker service
```
$ sudo systemctl start docker && sudo systemctl enable docker
```

testing
```
$ docker version
$ docker --version
```



## Install Docker-Compose
Way1: (Refer to: https://docs.docker.com/compose/install/)
```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

Way2: (Refer to: https://docs.docker.com/compose/install/#install-using-pip)
```
$ sudo pip3 install docker-compose
```

testing
```
$ docker-compose version
$ docker-compose --version
```



## Pull Ansible Labs

```
|---/~/playground/example
    |--ansible.cfg    #設定檔(-)
    |--inventory      #主機列表檔(-)
```

Step 1: cd folder labs
```
$ cd labs
```

Step 2: Pull image from DockerHub.
 
```
$ docker-compose up -d
```

Step 3: Check Docker status
```
$ docker-compose ps
```

Step 4: SSH into workstation
```
$ ssh student@10.10.10.10
```

If you want to remove lab...
```
$ docker-compose down
$ docker rmi -f [docker image name]
$ docker system prume

$ docker image ls
$ docker image -f prune
$ docker image rm [docker image Name]

$ docker volume ls
$ docker volume -f prune
$ docker volume rm [docker volume Name]

$ docker netwoek ls
$ docker netwoek -f prune
$ docker network rm [docker network Name]
```


## Let's Ansible!
Step 1: cd folder
```
$ cd ~/playground/example
```

Step 2: PING-PONG all hosts
```
$ ansible all -m ping
```



## Issue check
If ssh logining, the following is displayed.
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
> Someone could be eavesdropping on you right now (man-in-the-middle attack)!
> It is also possible that a host key has just been changed.
> The fingerprint for the ECDSA key sent by the remote host is
> SHA256:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
> Please contact your system administrator.
> Add correct host key in /Users/elite/.ssh/known_hosts to get rid of this message.
> Offending ECDSA key in /Users/elite/.ssh/known_hosts:10
> ECDSA host key for xxx.xx.xxx.xx has changed and you have requested strict checking.
> Host key verification failed.

Just delete ~/.ssh/known_hosts on your local host, not docker hosts.
```
$ rm -rf ~/.ssh/known_hosts
```
