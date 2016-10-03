# Run this script with `$ ruby my_script.rb`
require 'sqlite3'
require 'active_record'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
  end

  create_table :messages, force: true do |t|
    t.string :body
    t.belongs_to :user, index: true
  end
end

# Define the models
class User < ActiveRecord::Base
  has_many :messages, inverse_of: :user
end

class Message < ActiveRecord::Base
  belongs_to :user, inverse_of: :messages, required: true
end

# Create a few records...
# user = User.create!(name: 'Big Bang Theory')

# first_episode = user.messages.create!(body: 'Pilot')
# second_episode = user.messages.create!(body: 'The Big Bran Hypothesis')

# episode_names = user.messages.pluck(:body)

# puts "#{user.name} has #{user.messages.size} episodes named #{episode_names.join(', ')}."
# => Big Bang Theory has 2 episodes named Pilot, The Big Bran Hypothesis.

# Use `binding.pry` here to experiment with this setup.