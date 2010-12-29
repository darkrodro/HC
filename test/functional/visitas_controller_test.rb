require 'test_helper'

class VisitasControllerTest < ActionController::TestCase
  setup do
    @visita = visitas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visitas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visita" do
    assert_difference('Visita.count') do
      post :create, :visita => @visita.attributes
    end

    assert_redirected_to visita_path(assigns(:visita))
  end

  test "should show visita" do
    get :show, :id => @visita.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @visita.to_param
    assert_response :success
  end

  test "should update visita" do
    put :update, :id => @visita.to_param, :visita => @visita.attributes
    assert_redirected_to visita_path(assigns(:visita))
  end

  test "should destroy visita" do
    assert_difference('Visita.count', -1) do
      delete :destroy, :id => @visita.to_param
    end

    assert_redirected_to visitas_path
  end
end
