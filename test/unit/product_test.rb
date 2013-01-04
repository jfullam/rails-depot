require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "product attributes must not be empty " do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "price is great than 0" do
    product = Product.new title: "unique10asdfasdfasdfas", description:"blah, blah", image_url: "dkd.gif"

    product.price = 1
    assert product.valid?, "A price of #{product.price} should be valid as it's greater than 0."
    assert product.errors[:price].empty?

    product.price = 0
    assert product.invalid?
    assert product.errors[:price].any?


  end

  def create_new_product(image_url)
    product = Product.new title: 'unique20sdfasdfasdf', description: "desc", price: 0.90, image_url: image_url
  end

  test "image url is valid" do
    ok = ['one.gif', 'two.jpg', 'three.png']
    bad = ['ald', 'ldk.xls', 'lskd.pdf']

    ok.each  {|e| assert create_new_product(e).valid?, "#{e} should be valid"}
    bad.each {|e| assert create_new_product(e).invalid?, "#{e} should NOT be valid"}

  end

  test 'title is unique' do

    product = Product.new(title:       products(:ruby).title,
                          description: "yyy",
                          price:       1,
                          image_url:   "fred.gif")
    p product
    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end

end
