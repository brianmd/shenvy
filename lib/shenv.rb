require "shenv/version"

module Shenv
  module_function

  def env_diff(before, after)
    diff = []
    before.each do |key,val|
      diff << [key, after[key]] unless after[key]==val
    end
    new_keys = after.keys - before.keys
    new_keys.each{ |key| diff << [key, after[key]] }
    diff
  end

  def env_as_hash(env=env_as_array)
    hash = {}
    env.each{ |key,val| hash[key] = val }
    hash
  end

  def env_as_array
    env_rows = `set`.split("\n")
    pairs = env_rows.collect{ |row| row.split('=', 2) }
    pairs = pairs.select{ |key,val| !key.nil? and !val.nil? }
    pairs.collect do |key,val|
      val = if val.size>1 and val[0]=="'" and val[-1]=="'"
              val[1..-2]
            else
              val
            end
      [key,val]
    end
  end
end
