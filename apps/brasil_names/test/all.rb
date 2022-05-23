# frozen_string_literal: true

require 'test/unit'
require 'chespirito'

Dir['./apps/brasil-names/test/**/*.rb'].sort.each { |file| require file }
Dir['./apps/brasil-names/app/**/*.rb'].sort.each { |file| require file }
