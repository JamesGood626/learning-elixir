defmodule M do
  def main do
    name = IO.gets("What is your name? ") |> String.trim()
    IO.puts("Hello #{name}")
  end

  def do_stuff do
    data_stuff()
    # |> pipes data into what follows it
    (4 * 10) |> IO.puts()
  end

  def data_stuff do
    my_int = 123
    IO.puts("Integer #{is_integer(my_int)}")
  end
end

# This is a map, very similar to JavaScript objects
colors = %{primary: "red"}
# And to access properties on the map
colors.primary
# Or you can use pattern matching to pull out the value
# Both side's are a map, so they match, elixir will check the key
# primary on both the left and the right, and then compare the value
# since the left is a variable, it'll assign the rightside's value to that
# variable
%{primary: primary_color} = colors

# Now updating values in a map is not as simple as colors.primary = "blue"
# You must use a function provided by elixer to do so.
# Updating a map is an immutable operation, so the modification is made to a
# copy of the map, rather than mutating the underlying map.
# Refer to the Map module in the Elixir docs for all available methods
# put will successfully update the value for primary
Map.put(colors, :primary, "blue")

# You can also do this (However, this can only be used for updating, but not for adding a new key/value pair)
%{color | primary: "blue"}
# You can still use put to add a new key/value pair
Map.put(colors, :secondary, "green")

# Onwards to Keyword Lists
colors = [{:primary, "red"}, {:secondary, "blue"}]
# outputs [primary: "red", secondary: "blue"]
# accessing a property like so
colors[:primary]
# Even though the output looks like a list of key/value pairs
# Elixir still recognizes the underlying tuple structure
# and iterates through until finding the tuple containing the
# atom
# And you can also assign Keyword Lists like so:
colors = [primary: "red", secondary: "blue"]
# Unlike maps where having the same key declared twice,
# the later key will overwrite the first. ex:
colors = %{primary: "red", primary: "blue"}
# outputs %{primary: "blue"}
# However, this is not the case for Key Value lists
colors = [primary: "red", primary: "red"]
# outputs [primary: "red", primary: "red"]

# ecto, a library made for working with databases
# used with the Phoenix framework. It makes use of
# Keyword Lists for queries.
# The Keyword List's [] brackets may be omited if it's the
# only argument passed to the query.
query = User.find_where(where: user.age > 10, where: user.subscribed == true)
