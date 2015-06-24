every :day, :at => '12:00am' do
  runner "Tournament.mark_as_end"
end