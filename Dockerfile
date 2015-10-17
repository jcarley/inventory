# FROM jcarley/docker-ruby:2.2.3

FROM jruby:9.0.1.0-onbuild

RUN bash -c 'bundle exec rake tmp:clear tmp:create'
