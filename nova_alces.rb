require 'rubygems'
require 'bundler'
require_relative 'config.rb'
Bundler.require :default


Dir.foreach 'steps' do |step|
  if step.end_with? '.rb'
    require_relative('steps/' + step)
  end
end


Dir.foreach 'repos' do |repo|
  if repo.end_with? '.rb'
    require_relative('repos/' + repo)
  end
end


post '/github_hook' do
  digest = OpenSSL::Digest.new 'sha1'
  hmac = OpenSSL::HMAC.digest digest, GITHUB_WEBHOOK_SECRET, request[:payload]
  if headers['X-Hub-Signature'] == hmac
    response = JSON.parse request[:payload], {:symbolize_names => true}
    env = REFS.key response[:ref]
    repo = response[:repository][:name]
    if env
      case repo
      when 'robotmoose'
        robotmoose env
      else
        puts "Unknown repo: #{ repo }"
      end
    else
      puts "Unknown env: #{ env }"
    end
  else
    puts "Invalid HMAC"
  end
end

