require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :position => 2,
        :name => "Name",
        :price => 3.5,
        :description => "MyText",
        :prduct_type => 4
      ),
      Product.create!(
        :position => 2,
        :name => "Name",
        :price => 3.5,
        :description => "MyText",
        :prduct_type => 4
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
