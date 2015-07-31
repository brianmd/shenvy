require 'pathname'
require 'shenv/version'

module Shenv
  module_function

  def load(filename='.envrc')
    sourced_env = env(filename)
    sourced_env.each do |key,val|
      ENV[key] = val
    end
  end

  def env(filename='.envrc')
    str = `source '#{filename}' && set`
    env_as_hash(str)
  end

  def env_diff(before, after)
    diff = []
    before.each do |key,val|
      diff << [key, after[key]] unless after[key]==val
    end
    new_keys = after.keys - before.keys
    new_keys.each{ |key| diff << [key, after[key]] }
    diff
  end

  def env_as_hash(str=get_env)
    hash = {}
    env_as_array(str).each{ |key,val| hash[key] = val }
    hash
  end

  def env_as_array(str=get_env)
    env_rows = str.split("\n")
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

  def get_env
    `set`
  end
end
