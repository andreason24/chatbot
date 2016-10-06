require 'sqlite3'
require 'active_record'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
  end

  create_table :messages, force: true do |t|
    t.string :body
    t.belongs_to :user, index: true
  end
end
