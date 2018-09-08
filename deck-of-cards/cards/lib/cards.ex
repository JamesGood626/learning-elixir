defmodule Cards do
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
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
end
