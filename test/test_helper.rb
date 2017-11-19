# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "bundler/setup"
require "botkit"
require "minitest/utils"
require "minitest/autorun"

require_relative "./support/fake_bot"
