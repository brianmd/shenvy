require 'spec_helper'

describe Shenvy do
  let(:example_env) { Pathname(__FILE__).dirname + 'example_env' }

  it 'loads existing environment into a hash' do
    shenvy_key = 'this is a shenvy test'
    shenvy_val = '7'
    ENV[shenvy_key] = shenvy_val
    array = Shenvy
    env = Shenvy.env_as_hash
    expect(env[shenvy_key]).to eq(shenvy_val)
  end

  it 'loads existing environment with an equals sign in the value' do
    shenvy_key = 'this is a shenvy test 2'
    shenvy_val = '7 = 6 + 1'
    ENV[shenvy_key] = shenvy_val
    env = Shenvy.env_as_hash
    expect(env[shenvy_key]).to eq(shenvy_val)
  end

  it 'gets environment after sourcing a specific file' do
    env = Shenvy.env(example_env)
    expect(env['a']).to eq('a1')
    expect(env['b']).to eq('b1')
  end

  it "loads sourced environment into this ruby's ENV" do
    ENV['a'] = '0'
    ENV['b'] = '0'
    expect(ENV['a']).to eq('0')
    expect(ENV['b']).to eq('0')

    Shenvy.load(example_env)
    expect(ENV['a']).to eq('a1')
    expect(ENV['b']).to eq('b1')
  end

  it 'handles a missing environment file' do
    expect{ Shenvy.load('not-a-file') }.to raise_error(RuntimeError, /not found/)
  end

  it 'ensure environment file is executable.'
end
