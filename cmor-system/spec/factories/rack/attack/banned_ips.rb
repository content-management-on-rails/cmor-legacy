FactoryBot.define do
  factory :cmor_system_rack_attack_banned_ip, class: 'Cmor::System::Rack::Attack::BannedIp' do
    sequence(:key) { |i| "rack::attack:allow2ban:ban:10.1.1.#{i}" }
  end
end
