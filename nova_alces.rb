require 'rubygems'
require 'bundler'
require_relative 'config.rb'
Bundler.require :default

Dir.foreach 'steps' do |step|
  require_relative('steps/' + step) if step.end_with? '.rb'
end

Dir.foreach 'repos' do |repo|
  require_relative('repos/' + repo) if repo.end_with? '.rb'
end

post '/github_hook' do
  digest = OpenSSL::Digest.new 'sha1'
  hmac = OpenSSL::HMAC.digest digest, GITHUB_WEBHOOK_SECRET, request[:payload]
  if headers['X-Hub-Signature'] == hmac
    response = JSON.parse request[:payload], symbolize_names: true
    env = REFS.key response[:ref]
    repo = response[:repository][:name]
    if env
      case repo
      when 'robotmoose'
        robotmoose env
      else
        halt 400, "Unknown repo: #{repo}"
      end
    else
      halt 400, "Unknown env: #{env}"
    end
  else
    halt 401, 'Invalid HMAC'
  end
end

get '/' do
  'Nova Alces is running.'
end
