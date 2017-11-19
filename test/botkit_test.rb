# frozen_string_literal: true

require "test_helper"

class BotkitTest < Minitest::Test
  test "reports failures back to the bot instance" do
    error = StandardError.new("Failure")
    bot = FakeBot.new

    bot.expects(:report_exception).with(error)
    bot.stubs(:call).raises(error)

    Botkit.run(bot)
  end

  test "sets interval during every loop" do
    bot = FakeBot.new

    bot.stubs(:halt?).returns(false, true)
    Botkit::Runner.any_instance.expects(:sleep).with(1)

    Botkit.run(bot)
  end

  test "triggers message event" do
    bot = FakeBot.new
    message = Botkit::Message.new(text: "TEXT")
    callable = -> {}

    bot.message(&callable)

    callable.expects(:call).with(message)

    bot.handle_incoming_message(message)
  end

  test "triggers command event" do
    bot = FakeBot.new
    message = Botkit::Message.new(**bot.parse_message("/foo TEXT"))
    callable = -> {}

    bot.command(:foo, &callable)

    callable.expects(:call).with(message)

    bot.handle_incoming_message(message)
  end

  test "triggers exception event" do
    bot = FakeBot.new
    error = StandardError.new("ERROR")
    callable = -> {}

    bot.exception(&callable)

    callable.expects(:call).with(error)

    bot.report_exception(error)
  end

  test "parses command" do
    bot = FakeBot.new
    result = bot.parse_message("/foo")

    assert_equal "foo", result[:command]
    assert_nil result[:text]
  end

  test "parses command with arguments" do
    bot = FakeBot.new
    result = bot.parse_message("/foo TEXT")

    assert_equal "foo", result[:command]
    assert_equal "TEXT", result[:text]
  end

  test "parses message" do
    bot = FakeBot.new
    result = bot.parse_message("TEXT")

    assert_equal "TEXT", result[:text]
    assert_nil result[:command]
  end

  test "parses command from Telegram" do
    bot = FakeBot.new
    result = bot.parse_message("/foo@SomeBot TEXT")

    assert_equal "foo", result[:command]
    assert_equal "TEXT", result[:text]
  end

  test "replies are sent as regular messages by default" do
    bot = FakeBot.new
    message = Botkit::Message.new(text: "TEXT")
    reply = Botkit::Message.new(text: "REPLY")

    bot.expects(:send_message).with(reply)

    bot.reply_message(message, reply)
  end

  test "halt? returns instance variable" do
    bot = Botkit::Bot.new

    refute bot.halt?

    bot.instance_variable_set(:@halt, true)

    assert bot.halt?
  end
end
