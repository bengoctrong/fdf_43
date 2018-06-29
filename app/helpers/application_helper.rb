module ApplicationHelper
  def full_title page_title
    base_title = t "base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def choose_product_type
    options_for_select([Settings.food,Settings.drink],Settings.food)
  end

  def choose_category_id
    options_for_select(@categories.collect{|u| [u.name, u.id]},
      selected: Settings.one_value)
  end
end
