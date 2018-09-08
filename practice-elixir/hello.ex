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
