# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120509180839) do

  create_table "flights", :force => true do |t|
    t.decimal  "price",        :precision => 12, :scale => 2
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "hops_count",                                  :default => 0, :null => false
    t.integer  "way_duration",                                :default => 0, :null => false
  end

  add_index "flights", ["hops_count"], :name => "index_flights_on_hops_count"
  add_index "flights", ["way_duration"], :name => "index_flights_on_way_duration"

  create_table "hops", :force => true do |t|
    t.decimal  "latstart",    :precision => 8, :scale => 6, :null => false
    t.decimal  "lonstart",    :precision => 9, :scale => 6, :null => false
    t.decimal  "latend",      :precision => 8, :scale => 6, :null => false
    t.decimal  "lonend",      :precision => 9, :scale => 6, :null => false
    t.datetime "date",                                      :null => false
    t.integer  "duration",                                  :null => false
    t.integer  "flight_id",                                 :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "prev_hop_id"
  end

  add_index "hops", ["date"], :name => "index_hops_on_date"
  add_index "hops", ["flight_id"], :name => "index_hops_on_flight_id"
  add_index "hops", ["prev_hop_id"], :name => "index_hops_on_prev_hop_id"

end
