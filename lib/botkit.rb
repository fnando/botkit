# frozen_string_literal: true

module Botkit
  require "botkit/version"
  require "botkit/runner"

  def self.run(bot, **kwargs)
    Runner.new(bot, **kwargs).call
  end
end
