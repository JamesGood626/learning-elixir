defmodule Identicon.Image do
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end

# Going to be making use of Structs to manage
# the data flowing through this application.
# Structs are just like Maps, but they
# have to benefits over Maps.
# 1. They can be assigned default values.
# 2. They have some additional compile
# time checking of properties.
# nil is the default value
# defstruct hex: nil

# %Identicon.Image{}
# outputs %Identicon.Image{hex: nil}

# %Identicon.Image{hex: []}
# outputs %Identicon.Image{hex: []}

# The compile time checking is just a matter of
# the Struct only allowing properties we defined
# to be inserted into the Struct, whereas Maps can
# have any artbitrary property added to it.
