require 'test_helper'
class CrowdTest < ActiveSupport::TestCase

  def test_need_approvation
    assert Crowd.new.need_approvation?
  end

end
