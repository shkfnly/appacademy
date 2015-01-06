require 'addressable/uri'
require 'rest-client'
#
# url = Addressable::URI.new(
# scheme: 'http',
# host: 'localhost',
# port: 3000,
# path: '/users'
# ).to_s

# url = Addressable::URI.new(
# scheme: 'http',
# host: 'localhost',
# port: 3000,
# path: '/users',
# query_values: {
#   'some_category[a_key]' => 'another value',
#   'some_category[a_second_key]' => 'yet another value',
#   'some_category[inner_inner_hash][key]' => 'value',
#   'something_else' => 'aaahhhhh'
# }
# ).to_s

def create_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.json'
  ).to_s

  puts RestClient.post(
  url,
  { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
  )
end

def show_user_2
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/2'
  ).to_s

  puts RestClient.get(
  url
  )
end

#puts RestClient.get(url, {:params => {:id => 50, 'foo' => 'bar'}})
# puts RestClient.get(url)

#create_user
show_user_2
