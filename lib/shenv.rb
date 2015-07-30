require "shenv/version"

module Shenv
  module_function

  def env_as_hash
    hash = {}
    env_as_array.each{ |key,val| hash[key] = val }
    hash
  end

  def env_as_array
    env_rows = `set`.split("\n")
    env_rows.collect{ |row| row.split('=') }
  end
end
