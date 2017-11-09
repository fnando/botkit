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
        next_tick
        break if bot.halt?
        sleep(polling)
      end
    end

    private def next_tick
      bot.call
    rescue StandardError => exception
      bot.report_exception(exception)
    end
  end
end
