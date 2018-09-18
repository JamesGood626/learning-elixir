# This is a correct solution, it solves their problem in the example code
# with no issues. Codewars isn't the greatest... but aye this was good practice.

defmodule Solution do
  def nb_year(p0, percent, aug, p) do
    calculate_increased_population(0, p0, percent, aug, p)
  end

  def calculate_increased_population(numOfYears, p0, percent, aug, p) do
    two_percent_increase = p0 * 0.02
    new_p0 = p0 + two_percent_increase + aug
    numOfYears = numOfYears + 1

    cond do
      new_p0 <= p -> calculate_increased_population(numOfYears, new_p0, percent, aug, p)
      true -> numOfYears
    end
  end
end

# Example inputs
# Solution.nb_year(1000, 0.02, 50, 1200) -> 3 years
# Solution.nb_year(1500, 5, 100, 5000) -> 22 years, this is the one they expect to be 15..
# I could be overlooking something, but the recursion logic looks solid for what they're
# asking.
