# frozen_string_literal: true

module Botkit
  require "aitch"
  require "signal"

  require "botkit/version"
  require "botkit/runner"
  require "botkit/message"
  require "botkit/bot"

  def self.run(bot, **kwargs)
    Runner.new(bot, **kwargs).call
  end
end
