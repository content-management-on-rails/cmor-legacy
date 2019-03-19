module Cmor::UserAreaHelper
  def render_user_navigation(*args)
    options = args.extract_options!
    options.reverse_merge!(dropdown: false, bootstrap_version: 3)
    dropdown = options.delete(:dropdown)
    bootstrap_version = options.delete(:bootstrap_version)


    if dropdown
      render partial: "cmor/user_area/navigation_dropdown/bootstrap#{bootstrap_version}"
    else
      render partial: 'cmor/user_area/navigation'
    end
  end
end
