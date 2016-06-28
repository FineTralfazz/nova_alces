# nova_alces
Minimal code deployment tool designed primarily for @robotmoose, but I'll probably use it for other stuff too.

# Setup
* Install Ruby (and the gem package manager, if it's not bundled with your install)
* Install Bundler (`gem install bundler`)
* Run Bundler from the project directory (`bundler install`)
* Copy `config.rb.example` to `config.rb` and modify it to your needs.
* Write steps and define repos, then edit `nova_alces.rb` to run your repo function when the repo is pushed to. (note to self: make this less gross)
* Start Nova Alces (`ruby nova_alces.rb`)
* Create GitHub push webhook(s) for the push event, pointing at your-address/github_hook

# Contributing
* Before committing, run [RuboCop](https://github.com/bbatsov/rubocop) to check your code style.
