module ApplicationHelper
  def sortable(column, title = nil, condition_params)
    title ||= column.titleize
    if column == params[:sort] && params[:direction] == 'asc'
      direction = 'desc'
      direction_css_class = 'glyphicon-sort-by-attributes'
    else
      direction = 'asc'
      direction_css_class = 'glyphicon-sort-by-attributes-alt'
    end
    css_class = (column == params[:sort]) ? "glyphicon #{ direction_css_class }" : 'glyphicon glyphicon-sort'
    link_to title, condition_params.merge({:sort => column, :direction => direction}), {:class => css_class}
  end

  def nav_link(link_text, link_path, icon_name = '', active_conditions_arr = [], icon_pos = 'left')
    class_name = request.path == (link_path.split('?').first) ? 'active' : ''

    if active_conditions_arr.size > 0 && class_name != 'active'
      is_match = active_conditions_arr.find { |condition|
        condition[:controller_path] == controller_path && condition[:action_name] == action_name
      }
      class_name = is_match ? 'active' : ''
    end

    if icon_name
      if icon_pos == 'right'
        link_text += fa_icon(icon_name)
      else
        link_text = fa_icon(icon_name) + link_text
      end
    end

    content_tag(:li, :class => class_name) do
      link_to link_path do
        link_text
      end
    end
  end

  def can_access?(user_permissions, controller_path, action_name)
    # Always pass if current user is admin
    return true if user_permissions.include?('admin')

    # Otherwise check for permission to show/hide screen items
    user_permissions.find { |permission|
      ['/', permission.controller_path].join('') == controller_path && permission.action_name == action_name
    }
  end

  def format_time(time)
    time = time.to_datetime if time.is_a? Date
    if time
      l(time, format: :default)
    end
  end

  def format_time_only_YM(time)
    time = time.to_datetime if time.is_a? Date
    if time
      l(time, format: :only_year_month)
    end
  end

  def format_time_without_timezone(time)
    time = time.to_datetime if time.is_a? Date
    if time
      l(time, format: :without_timezone)
    end
  end

  def format_money_amount(num)
    if num.blank? || num == 0
      return num
    end

    if num > 0
      ['+', number_to_currency(num)].join()
    else
      ['', number_to_currency(num)].join()
    end
  end

  def format_percentage(num)
    if num.blank? || num == 0
      return num
    end

    if num > 0
      ['+', number_to_percentage(num, precision: 2)].join()
    else
      ['', number_to_percentage(num, precision: 2)].join()
    end
  end

  def input_error_message(arr)
    return unless arr
    arr.collect { |msg| content_tag(:span, msg, class: 'help-block') }.join.html_safe
  end
end
