# frozen_string_literal: true

require 'test/unit'
require 'chespirito'

Dir['./apps/covid19/test/**/*.rb'].sort.each { |file| require file }
Dir['./apps/covid19/app/**/*.rb'].sort.each { |file| require file }
