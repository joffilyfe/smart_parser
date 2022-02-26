# frozen_string_literal: true

FactoryBot.define do
  factory :log, class: Array do
    lines do
      [build_list(:line, 20, path: '/home', ip: random_ipv4),
       build_list(:line, 10, path: '/then/10', ip: random_ipv4),
       build_list(:line, 1, path: '/two/2', ip: random_ipv4),
       build_list(:line, 5, path: '/five', ip: random_ipv4),
       build_list(:line, 1, path: '/two/2', ip: random_ipv4)].flatten.shuffle
    end

    initialize_with { lines }
    to_create { initialize_with }
  end
end
