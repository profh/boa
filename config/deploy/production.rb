set :bundle_without, [:development, :test]
set :rails_env, 'production'
set :branch, :master
server 'trailer-02.springcarnival.org', :app, :web, :db, :primary => true
