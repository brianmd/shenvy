require 'pathname'
require 'shenvy/version'

module Shenvy
  module_function

  def load(filename='.env')
    sourced_env = env(filename)
    sourced_env.each do |key,val|
      ENV[key] = val
    end
  end

  def env(filename='.env')
    path = Pathname.new(filename).expand_path
    raise  "File #{path} not found" unless path.exist?
    str = `source '#{path}' && set`
    env_as_hash(str)
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
