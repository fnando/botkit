# frozen_string_literal: true

require "test_helper"

class BotkitTest < Minitest::Test
  test "reports failures back to the bot instance" do
    error = StandardError.new("Failure")
    bot = Object.new

    bot.expects(:report_exception).with(error)
    bot.expects(:call).raises(error)
    bot.stubs(:halt?).returns(true)

    Botkit.run(bot)
  end

  test "sets interval during every loop" do
    bot = Object.new

    bot.stubs(:call)
    bot.stubs(:halt?).returns(false, true)
    Botkit::Runner.any_instance.expects(:sleep).with(1)

    Botkit.run(bot)
  end
end
