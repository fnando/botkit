# frozen_string_literal: true

class FakeBot < Botkit::Bot
  def halt?
    true
  end

  def call
  end
end
