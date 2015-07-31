require 'spec_helper'

describe Shenv do
  it 'loads existing environment from file' do
    shenv_key = 'this is a shenv test'
    shenv_val = '7'
    ENV[shenv_key] = shenv_val
    array = Shenv
    env = Shenv.env_as_hash
    expect(env[shenv_key]).to eq(shenv_val)
  end

  it 'loads existing environment from file with an equals sing in the value' do
    shenv_key = 'this is a shenv test'
    shenv_val = '7 = 6 + 1'
    ENV[shenv_key] = shenv_val
    env = Shenv.env_as_hash
    expect(env[shenv_key]).to eq(shenv_val)
  end

  it 'get changes from two environments' do
    env_before = Shenv.env_as_hash
    shenv_key = 'this is a shenv test 2'
    shenv_val = '7 = 6 + 2'
    ENV[shenv_key] = shenv_val
    env_after = Shenv.env_as_hash
    diff = Shenv.env_diff(env_before, env_after)
    expect(diff).to eq([[shenv_key, shenv_val]])
  end
end
