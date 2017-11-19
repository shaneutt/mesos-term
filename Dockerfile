FROM node:8.9.1

RUN apt-get update
RUN apt-get install -y python3 python3-pip

WORKDIR /usr/app

ADD package.json package.json
RUN npm install

ADD scripts/entrypoint.sh /entrypoint.sh
ADD src src

ADD https://github.com/clems4ever/mesos-task-exec/archive/v0.1.0.tar.gz .
RUN tar xzvf v0.1.0.tar.gz -C /tmp && cd /tmp/mesos-task-exec-0.1.0 && pip3 install -r requirements.yml

ENV MESOS_TASK_EXEC_PATH=/tmp/mesos-task-exec-0.1.0/src/app.py
ENV MESOS_MASTER_URL=http://localhost:5050

CMD ["/entrypoint.sh"]