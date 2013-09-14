require 'test_helper'
class MessageTest < ActiveSupport::TestCase

  def test_valide_presence_of_boby
    message = Fabricate.build :message, body: nil
    assert message.valid? == false
    assert message.errors[:body] != nil
  end

  def test_validate_presence_of_sender
    message = Fabricate.build :message, sender: nil
    assert message.valid? == false
    assert message.errors[:sender] != nil
  end

  def test_validate_presence_of_topic
    message = Fabricate.build :message, topic: nil
    assert message.valid? == false
    assert message.errors[:sender] != nil
  end

  def test_has_many_deliveries
    message = Fabricate :message
    3.times { Fabricate "Messages::Delivery", message: message  }
    assert message.deliveries.is_a? ActiveRecord::Relation
    assert message.deliveries.count > 0
  end

end
