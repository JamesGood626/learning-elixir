defmodule ReverseInt do
  def main(int) do
    Integer.to_string(int)
    |> String.reverse()
    |> check_for_negative()
  end

  def check_for_negative(str) do
    case String.contains?(str, "-") do
      true -> str
      false -> str
    end
  end

  def reverse_negative_sign(str) do
    String.replace_suffix(str, '')
  end
end
