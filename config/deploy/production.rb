role :app, %w{52.74.136.251}
role :web, %w{52.74.136.251}
role :db,  %w{52.74.136.251}

server '52.74.136.251', user: 'ubuntu', roles: %w{web app}, my_property: :my_value

# set it globally
  set :ssh_options, {
    keys: %w(/home/optimus/sud123.pem),
    forward_agent: true,
    auth_methods: %w(publickey)
  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
