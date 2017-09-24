# frozen_string_literal: true

FactoryGirl.define do
  factory :mp3 do
    title      { FFaker::Lorem.word }
    interpret  { FFaker::Name.name    }
    album      { FFaker::Lorem.sentence(2) }
    track      { rand(20) }
    year       { 1900 + rand(117) }
  end
end
