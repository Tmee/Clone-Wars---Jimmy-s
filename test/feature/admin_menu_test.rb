require_relative "./feature_test_helper"
require_relative './admin_menu'

class AdminMenuTest < FeatureTest

  def test_it_has_a_home_page
    visit '/admin/menu'
    assert true
  end

  def test_it_has_css
    visit '/admin/menu'
    assert page.has_css?('.textarea_short_and_tall')
  end

  def test_it_has_item_description
    visit '/admin/menu'
    expect(page).to have_content 'item.description'
  end

  def test_it_has_item_name
    visit '/admin/menu'
    expect(page).to have_content 'item.name'
  end

  def test_it_has_item_category
    visit '/admin/menu'
    expect(page).to have_content 'item.title'
  end
end
