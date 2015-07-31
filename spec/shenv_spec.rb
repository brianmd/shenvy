require 'spec_helper'

describe Shenv do
  it 'loads existing environment into a hash' do
    shenv_key = 'this is a shenv test'
    shenv_val = '7'
    ENV[shenv_key] = shenv_val
    array = Shenv
    env = Shenv.env_as_hash
    expect(env[shenv_key]).to eq(shenv_val)
  end

  it 'loads existing environment with an equals sign in the value' do
    shenv_key = 'this is a shenv test 2'
    shenv_val = '7 = 6 + 1'
    ENV[shenv_key] = shenv_val
    env = Shenv.env_as_hash
    expect(env[shenv_key]).to eq(shenv_val)
  end

  it 'gets environment after sourcing a specific file' do
    env = Shenv.env('spec/example_env')
    expect(env['a']).to eq('a1')
    expect(env['b']).to eq('b1')
  end

  it "loads sourced environment into this ruby's ENV" do
    ENV['a'] = '0'
    ENV['b'] = '0'
    expect(ENV['a']).to eq('0')
    expect(ENV['b']).to eq('0')

    Shenv.load('spec/example_env')
    expect(ENV['a']).to eq('a1')
    expect(ENV['b']).to eq('b1')
  end

  it 'handles a missing environment file'
end
