echo -e "\ngroup :test do\ngem 'rspec-rails', '~> 3.6.0'\ngem 'factory_bot_rails'\ngem 'rspec-parameterized'\ngem 'faker' #ランダム値の生成\ngem 'shoulda-matchers'\ngem 'rails-controller-testing'\nend" >> Gemfile
cp -r ../../RspecBookers2Debug/spec/ ./
bundle install
bundle exec rspec spec/ --format documentation 

