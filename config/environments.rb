#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path

configure :development do
  set :database, 'sqlite:///db/development.db'
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end
