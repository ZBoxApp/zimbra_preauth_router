FROM phusion/passenger-ruby21:0.9.15
MAINTAINER Patricio Bruna <pbruna@itlinux.cl>

RUN rm -f /etc/service/nginx/down
RUN mkdir -p /home/app/zimbra_pre_auth_router
RUN mkdir -p /home/app/zimbra_pre_auth_router/tmp

WORKDIR /home/app/zimbra_pre_auth_router
ADD Gemfile /home/app/zimbra_pre_auth_router
ADD Gemfile.lock /home/app/zimbra_pre_auth_router
RUN bundle install

ADD config/zimbra_preauth_router-nginx.conf /etc/nginx/sites-enabled/zimbra_preauth_router-nginx.conf
ADD config/nginx-env.conf /etc/nginx/main.d/nginx-env.conf
ADD config/pbruna-ssh-key.pub /tmp/your_key
RUN cat /tmp/your_key >> /root/.ssh/authorized_keys && rm -f /tmp/your_key
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN chown 9999:9999 /var/log/delayed_job.log

# Aquí para que no moleste al cache
ADD . /home/app/zimbra_pre_auth_router

RUN chown 9999:9999 -R /home/app/zimbra_pre_auth_router

CMD ["/sbin/my_init"]