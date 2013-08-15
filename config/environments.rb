#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path

configure :development do
  set :database, 'sqlite://db/development.db'
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :encoding => 'utf8',
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :database => db.path[1..-1],
    :username => db.user,
    :password => db.password
  )
end
