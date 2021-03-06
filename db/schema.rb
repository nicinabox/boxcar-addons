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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130826040632) do

  create_table "addons", force: true do |t|
    t.string "name"
    t.string "endpoint"
  end

  create_table "packages", force: true do |t|
    t.string "name"
    t.string "version"
    t.string "arch"
    t.string "build"
    t.string "package_name"
    t.string "location"
    t.string "size_uncompressed"
    t.string "size_compressed"
    t.string "slackware_version"
  end

  create_table "versions", force: true do |t|
    t.string "version"
    t.string "name"
    t.string "description"
    t.string "author"
    t.string "homepage"
    t.string "addon_id"
  end

end
