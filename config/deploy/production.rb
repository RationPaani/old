role :app, %w{54.254.190.184}
role :web, %w{54.254.190.184}
role :db,  %w{54.254.190.184}

server '54.254.190.184', user: 'ubuntu', roles: %w{web app}, my_property: :my_value

# set it globally
  set :ssh_options, {
    keys: %w(/home/optimus/aws_keypair.pem),
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
