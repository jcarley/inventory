pidfile "tmp/puma.pid"
state_path "tmp/puma.state"
bind 'tcp://0.0.0.0:3000'
environment 'development'

threads 5, 16

# Use the following curl request to get stats about puma
# curl 127.0.0.1:6464?token=foo
activate_control_app 'tcp://0.0.0.0:6464', { auth_token: 'foo' }

