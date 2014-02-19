module ApplicationHelper
  def pretty_date(d)
    d.in_time_zone("Pacific Time (US & Canada)").strftime("%-m/%-d/%Y")
  end
  def pretty_time(t)
    t.in_time_zone("Pacific Time (US & Canada)").strftime("%-I:%M%P")
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def active_class(path)
    request.path =~ /#{path}/ ? 'active' : nil
  end
end
