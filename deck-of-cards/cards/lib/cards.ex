defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # suits is the nested iteration. #Idiomatic
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    # Immutability in action, returns a new list, doesn't modify the existing deck list in memory.
    Enum.shuffle(deck)
  end

  # Valid to use ? in func declaration. Indicates boolean is returned.
  @doc """
    Determines whether a deck contains a given card

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  # This is pattern matching (elixir's replacement for variable assignment)
  # When pattern matching use an _ at the beginning of the pattern match name
  # to ignore/not use it.
  # returns a tuple { deck, rest_of_deck } = Enum.split(deck, 5)
  # can't access elements in tuple using Enum.split(deck, 5)[0]
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be
    in the hand.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  # Case statement w/ pattern matching
  # :ok case returns the binary from this load function
  # :ok and :error are atoms (primative data type)
  # Think of atoms as being like strings but
  # They're for codifying error messages
  # In one line of code we're doing two operations
  # both comparing the result of File.read and assigning
  # the second returned element of File.read to the binary.
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  # The pipe operator, another major feature of Elixir
  # Whatever gets returned from the previous function
  # is passed into the next
  # And in the case of Cards.deal, hand_size is the second argument
  # So deck is being passed in as the first automatically.
  # Can't pipe to the second argument.
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end

# More on pattern matching
# color = "red" (color will be "red")
# [color] = ["blue"] (color will be "blue")

# Expanding on pattern matching
# ["red", color] = ["red", "blue"]
# "red" on the left remains "red", and color is "blue"
# And this won't work
# ["red", color] = ["green", "blue"]
# If we put a hard coded value, Elixir requires the right
# hand side to have the equivalent value in it's position.

# Replaced this code with what's currently in load(filename)
# {status, binary} = File.read(filename)

# case status do
#   :ok -> :erlang.binary_to_term(binary)
#   :error -> "That file does not exist"
# end
