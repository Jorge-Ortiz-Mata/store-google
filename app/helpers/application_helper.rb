module ApplicationHelper
  def error_border(has_error)
    return unless has_error

    'border border-red-500'
  end
end
