module ApplicationHelper
  def pretty_date(d)
    d.in_time_zone("Pacific Time (US & Canada)").strftime("%-m/%-d/%Y")

  end
  def pretty_time(t)
    t.in_time_zone("Pacific Time (US & Canada)").strftime("%-I:%M%P")
  end
end
