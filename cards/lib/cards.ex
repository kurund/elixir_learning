defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of string representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a shuffled deck of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Checks of a card is in the deck.

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Splits a deck into hand and remaining deck.
    The `hand size` argument indicates how many cards to draw from the deck.

  ## Example
      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Hearts"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves the deal to the filesystem.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck from the filesystem.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end
  end

  @doc """
    Returns the number of cards in the deck.
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
