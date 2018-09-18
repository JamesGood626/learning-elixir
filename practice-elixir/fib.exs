defmodule Fib do
  def main(num) do
    fibFun = fn
      {0, 0, n} -> "FizzBuzz"
      {0, b, n} -> "Fizz"
      {a, 0, n} -> "Buzz"
      {a, b, n} -> n
    end

    fibFun.({rem(num, 3), rem(num, 5), num})
  end
end
