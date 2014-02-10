module EntriesHelper
  def options_for_sort
    [ "<option value='created_at'>Date</option>",
      "<option value='best_score'>Best Score</option>",
      "<option value='up_votes'>Up-Votes</option>",
      "<option value='down_votes'>Down-Votes</option>"
    ].join.html_safe
  end
end
