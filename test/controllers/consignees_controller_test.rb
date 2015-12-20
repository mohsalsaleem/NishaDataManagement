require 'test_helper'

class ConsigneesControllerTest < ActionController::TestCase
  setup do
    @consignee = consignees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:consignees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create consignee" do
    assert_difference('Consignee.count') do
      post :create, consignee: { address_line_1: @consignee.address_line_1, address_line_2: @consignee.address_line_2, city: @consignee.city, country: @consignee.country, email: @consignee.email, name: @consignee.name, po_box_no: @consignee.po_box_no, tel_no_1: @consignee.tel_no_1, tel_no_2: @consignee.tel_no_2 }
    end

    assert_redirected_to consignee_path(assigns(:consignee))
  end

  test "should show consignee" do
    get :show, id: @consignee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @consignee
    assert_response :success
  end

  test "should update consignee" do
    patch :update, id: @consignee, consignee: { address_line_1: @consignee.address_line_1, address_line_2: @consignee.address_line_2, city: @consignee.city, country: @consignee.country, email: @consignee.email, name: @consignee.name, po_box_no: @consignee.po_box_no, tel_no_1: @consignee.tel_no_1, tel_no_2: @consignee.tel_no_2 }
    assert_redirected_to consignee_path(assigns(:consignee))
  end

  test "should destroy consignee" do
    assert_difference('Consignee.count', -1) do
      delete :destroy, id: @consignee
    end

    assert_redirected_to consignees_path
  end
end
