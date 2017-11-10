# frozen_string_literal: true

module Botkit
  class Message
    attr_reader :text, :command, :matches, :raw, :options, :channel_id

    def initialize(text:, raw: {}, channel_id: nil, command: nil, matches: nil, options: {})
      @text = text
      @command = command
      @raw = raw
      @channel_id = channel_id
      @options = options
      @matches = matches
    end

    def command?
      command
    end
  end
end
