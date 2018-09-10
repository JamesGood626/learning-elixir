defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  # [r, g, b | _tail] for ignoring the rest
  # of the elements in hex_list for the
  # pattern matching
  # And you can pattern match inside of the
  # argument list
  # And you can do this for more than just one argument
  # (%Identicon.Image{hex: [r, g, b | _tail]} = image, {height, width} = size)
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  # the &mirror_row/1 is necessary for passing a callback func
  # notably the & and /1 (for the number of arguments the func takes)
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # example input [145, 45, 200]
    [first, second | _tail] = row
    row ++ [second, first]
    # example output [145, 46, 200, 46, 145]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  # Note how in the pattern matching inside of the argument,
  # That it's not using = image like the other functions above.
  # That's because it's not a requirement to add the = against
  # whatever you intend to destructure, but in the functions above
  # it was done so that a reference to image would still be available
  # inside of the function.
  # And egd is from the Erlang Graphical Library
  # And Enum.each will iterate over a collection, but unlike map
  # it's not going to return a new collection.
  # Inside of the Enum.each the image object is being modified
  # in place, unlike the standard, create a copy, edit that and then
  # return it.
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  # input is the filename where the image will be saved.
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end
end

# Generating the hash
hash = :crypto.hash(:md5, "banana")
# outputs
# <<114, 179, 2, 191, 41, etc...>>
Base.encode16(hash)
# outputs "72B302BF..."
# What we care about
:binary.bin_to_list(hash)
# [114, 179, 2, 191, 41, etc...]
# The numbers in the list range from 0-255
# so we'll use them as our color values
# and then the other numbers will be applied to
# the grid of squares in a pattern like so:
# 145 46 200 46 145
# 3 178 206 178 3
# etc..
# If the number in the square is even
# then it will be colored, otherwise it won't, and
# the matching numbers will be mirrored.
