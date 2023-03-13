install:
	rbenv install -s
	gem install bundler -N --conservative
	bundle install

test:
	bundle exec rspec
