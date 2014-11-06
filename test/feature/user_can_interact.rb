require_relative "./feature_test_helper"

class UserCanInteract < FeatureTest

  def test_it_has_a_home_page
    visit '/'
    assert page.has_css?('.flexslider')
    assert page.has_css?('img.nice-image')
    assert page.has_link?('Home')
    assert page.has_selector?('input[type="image"]')


  end

  # def test_it_has_a_home_page
  #   skip
  #   visit '/'
  #   assert page.has_css?('#flexslider slider')
  #   assert page.has_css?('#img src')
  #   assert page.has_css?('#idea-title')
  #   assert page.has_link?('Dashboard')
  #   assert page.has_selector?('input[type=submit][value=Submit]')
  # end
end
