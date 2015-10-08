FROM jcarley/docker-ruby:2.2.3


RUN bash -c 'bundle exec rake tmp:clear tmp:create'
