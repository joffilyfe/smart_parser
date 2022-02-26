# frozen_string_literal: true

AVAILABLE_PATHS = ['/home', '/path/1', '/path/2'].freeze

FactoryBot.define do
  factory :line, class: Array do
    transient do
      random_ip { true }
    end

    ip { random_ip ? random_ipv4 : '127.0.0.1' }
    path { AVAILABLE_PATHS.sample }

    initialize_with { "#{path} #{ip}" }
    to_create { initialize_with }
  end
end
