# frozen_string_literal: true

module Botkit
  class Message
    attr_reader :text, :command, :raw, :options, :channel_id, :id

    def initialize(text:, raw: {}, channel_id: nil, command: nil, options: {}, id: nil)
      @text = text
      @command = command
      @raw = raw
      @channel_id = channel_id
      @options = options
      @id = id
    end

    def command?
      command
    end
  end
end
