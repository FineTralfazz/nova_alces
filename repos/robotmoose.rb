def robotmoose(env)
  dir = DIRS[env]
  Dir.chdir dir
  git_pull
  build_superstar
  restart_service SERVICES[env][:superstar]
end
