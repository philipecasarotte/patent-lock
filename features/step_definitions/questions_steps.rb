Given /^I have no questions$/ do
  Question.destroy_all
end

Then /^I should have ([0-9+]) questions?$/ do |count|
  assert_equal Question.count, count.to_i
end
