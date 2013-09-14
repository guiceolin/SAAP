require 'test_helper'

class Messages::DeliveryTest < ActiveSupport::TestCase

  def new_delivery
    @delivery ||= Messages::Delivery.new
  end

  def test_validate_presence_of_recipient
    assert new_delivery.valid? == false
    assert new_delivery.errors[:recipient].any?
  end

  def test_validate_presence_of_message
    assert new_delivery.valid? == false
    assert new_delivery.errors[:message].any?
  end

  def test_unreaded_on_create
    assert new_delivery.readed == false
  end

end
