# frozen_string_literal: true

module Botkit
  class Runner
    attr_reader :bot, :polling

    def initialize(bot, polling: 1)
      @bot = bot
      @polling = polling
    end

    def call
      loop do
        tick

        break if bot.halt?

        sleep(polling)
      end
    end

    private def tick
      bot.call
    rescue StandardError => error
      bot.report_exception(error)
    end
  end
end
