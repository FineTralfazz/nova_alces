require 'rubygems'
require 'bundler'
require_relative 'config.rb'
Bundler.require :default

Dir.foreach 'steps' do |step|
  if step.end_with? '.rb'
    require_relative('steps/' + step)
  end
end


def run_steps(env)
  dir = DIRS[env]
  Dir.chdir dir
  git_pull
  build_superstar
  restart_service SERVICES[env]
end


post '/github_hook' do
  digest = OpenSSL::Digest.new 'sha1'
  hmac = OpenSSL::HMAC.digest digest, GITHUB_WEBHOOK_SECRET, request[:payload]
#  if headers['X-Hub-Signature'] == hmac
    response = JSON.parse request[:payload]
    puts response
    env = REFS.key response[:ref]
    if env
      run_steps env
    end
 # end
end

