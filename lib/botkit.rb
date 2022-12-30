# frozen_string_literal: true

module Botkit
  require "aitch"
  require "voltage"

  require_relative "botkit/version"
  require_relative "botkit/runner"
  require_relative "botkit/message"
  require_relative "botkit/bot"

  def self.run(bot, **kwargs)
    Runner.new(bot, **kwargs).call
  end
end
