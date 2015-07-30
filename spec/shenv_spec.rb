require 'spec_helper'

describe Shenv do
  it 'loads existing environment from file' do
    shenv_key = 'this is a shenv test'
    shenv_val = '7'
    ENV[shenv_key] = shenv_val
    env = Shenv.env_as_hash
    expect(env[shenv_key]).to eq(shenv_val)
  end
end
