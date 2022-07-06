FROM centos:7.9.2009
LABEL maintainer="dennischien <sdd9456@gmail.com>"
RUN yum install -y vim  net-tools telnet sudo passwd  openssh-* python3-dev* curl wget bash-completion openssl epel-release
RUN yum install ansible -y
RUN ssh-keygen -A
RUN echo  redhat | passwd  --stdin root
RUN useradd --create-home --shell /bin/bash  devops
RUN echo  redhat | passwd  --stdin devops
RUN echo 'devops ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN ssh-keygen -q  -N  "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >  ~/.ssh/authorized_keys
RUN useradd --create-home --shell /bin/bash  student
RUN echo  redhat | passwd  --stdin student
RUN echo 'student ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER devops
RUN ssh-keygen -q  -N  "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >  ~/.ssh/authorized_keys
USER student
RUN ssh-keygen -q  -N  "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >  ~/.ssh/authorized_keys  && mkdir -p ~/playground
RUN echo -e 'autocmd FileType yaml setlocal ai ts=2 sw=2 et\n:set cursorcolumn' > /home/student/.vimrc
COPY src/example.tar.gz /tmp/.
COPY src/labs.tar.gz /tmp/.
RUN tar -C /home/student/playground/  -zxvf /tmp/example.tar.gz
RUN tar -C /home/student/playground/  -zxvf /tmp/labs.tar.gz
USER root
RUN echo -e  "Host * \n \tStrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN cat /home/student/.ssh/id_rsa.pub >>  /home/devops/.ssh/authorized_keys && cat /home/devops/.ssh/id_rsa.pub >>  /home/student/.ssh/authorized_keys
RUN chown -R student:student /home/student/ && chown -R devops:devops /home/devops
EXPOSE 22