every :day, :at => '11:55pm' do
  runner "Tournament.mark_as_end"
end

every :day, :at => '11:55pm' do
  runner "User.reset_daily_bonus"
end