require 'test_helper'
class ProfessorTest < ActiveSupport::TestCase
  def test_needs_approvation
    assert !Professor.new.need_approvation?
  end
end
