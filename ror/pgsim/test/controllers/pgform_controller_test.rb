require 'test_helper'

class PgformControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pgform_index_url
    assert_response :success
  end

end
