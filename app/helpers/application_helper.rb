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

  # Detects which browser the user is using.
  def users_browser
    user_agent =  request.env['HTTP_USER_AGENT'].downcase
    @users_browser ||= begin
      if user_agent.index('msie') && !user_agent.index('opera') && !user_agent.index('webtv')
                  'ie'+user_agent[user_agent.index('msie')+5].chr
      elsif user_agent.index('gecko/')
          'gecko'
      elsif user_agent.index('opera')
          'opera'
      elsif user_agent.index('konqueror')
          'konqueror'
      elsif user_agent.index('ipod')
          'ipod'
      elsif user_agent.index('ipad')
          'ipad'
      elsif user_agent.index('iphone')
          'iphone'
      elsif user_agent.index('chrome/')
          'chrome'
      elsif user_agent.index('applewebkit/')
          'safari'
      elsif user_agent.index('googlebot/')
          'googlebot'
      elsif user_agent.index('msnbot')
          'msnbot'
      elsif user_agent.index('yahoo! slurp')
          'yahoobot'
      #Everything thinks it's mozilla, so this goes last
      elsif user_agent.index('mozilla/')
          'gecko'
      else
          'unknown'
      end
    end
    return @users_browser
  end

  # Detects is user is using an iOS browser.
  def detect_ios
    browser = users_browser
    if browser == 'iphone' || browser == 'ipad' || browser == 'iphone'
      return true
    else
      return false
    end
  end
end
