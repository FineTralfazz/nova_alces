def restart_service(name)
  `sudo service #{ name } restart`
end
