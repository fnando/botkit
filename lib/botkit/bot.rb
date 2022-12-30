# frozen_string_literal: true

module Botkit
  class Bot
    include Voltage

    # When setting `bot.halt = true`, the bot will be halted
    # after the current loop.
    attr_writer :halt

    def initialize
      @halt = false
    end

    # Detect if bot should halt himself from the loop.
    def halt?
      @halt
    end

    def call
    end

    def send_message(message)
    end

    def reply_message(_message, reply)
      send_message(reply)
    end

    def handle_incoming_message(message)
      if message.command?
        emit("command:#{message.command}", message)
      else
        emit("internal:message", message)
      end
    end

    def parse_message(input)
      input = input.to_s
      _, command, text =
        *input.match(%r{\A/([^ @]+)(?:@.*?bot)?(?:\s+(.*?))?\z}i)

      {
        command: command,
        text: command ? text : input
      }
    end

    def command(name, &block)
      on("command:#{name}", &block)
    end

    def message(&block)
      on("internal:message", &block)
    end

    def exception(&block)
      on("internal:exception", &block)
    end

    def report_exception(exception)
      emit("internal:exception", exception)
    end
  end
end
