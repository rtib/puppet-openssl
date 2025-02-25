# frozen_string_literal: true

require 'puppet'
require 'puppet/type/x509_cert'
describe Puppet::Type.type(:x509_cert) do
  let(:resource) { Puppet::Type.type(:x509_cert).new(path: '/tmp/foo') }

  it 'does not accept a non absolute path' do
    expect do
      Puppet::Type.type(:x509_cert).new(path: 'foo')
    end.to raise_error(Puppet::Error, %r{Path must be absolute: foo})
  end

  it 'accepts ensure' do
    resource[:ensure] = :present
    expect(resource[:ensure]).to eq(:present)
  end

  it 'accepts valid days' do
    resource[:days] = 365
    expect(resource[:days]).to eq(365)
  end

  it 'does not accept invalid days' do
    expect do
      resource[:days] = :foo
    end.to raise_error(Puppet::Error, %r{Invalid value :foo})
  end

  it 'accepts valid template' do
    resource[:template] = '/tmp/foo.cnf'
    expect(resource[:template]).to eq('/tmp/foo.cnf')
  end

  it 'does not accept non absolute template' do
    expect do
      resource[:template] = 'foo.cnf'
    end.to raise_error(Puppet::Error, %r{Path must be absolute: foo\.cnf})
  end

  it 'accepts a password' do
    resource[:password] = 'foox2$bar'
    expect(resource[:password]).to eq('foox2$bar')
  end

  it 'accepts a valid force parameter' do
    resource[:force] = true
    expect(resource[:force]).to eq(:true)
  end

  it 'does not accept a bad force parameter' do
    expect do
      resource[:force] = :foo
    end.to raise_error(Puppet::Error, %r{Invalid value :foo})
  end

  it 'accepts a valid req_ext parameter' do
    resource[:req_ext] = true
    expect(resource[:req_ext]).to be(true)
  end

  it 'does not accept a bad req_ext parameter' do
    expect do
      resource[:req_ext] = :foo
    end.to raise_error(Puppet::Error, %r{Invalid value :foo})
  end

  it 'accepts a valid csr parameter' do
    resource[:csr] = '/tmp/foo.csr'
    expect(resource[:csr]).to eq('/tmp/foo.csr')
  end

  it 'accepts mode' do
    resource[:mode] = '0700'
    expect(resource[:mode]).to eq('0700')
  end

  it 'does not accept numeric mode' do
    expect do
      resource[:mode] = '700'
    end.to raise_error(Puppet::Error, %r{700 is not a valid file mode})
  end

  it 'accepts owner' do
    resource[:owner] = 'someone'
    expect(resource[:owner]).to eq('someone')
  end

  it 'does not accept bad owner' do
    expect do
      resource[:owner] = 'someone else'
    end.to raise_error(Puppet::Error, %r{someone else is not a valid user name})
  end

  it 'accepts group' do
    resource[:group] = 'party'
    expect(resource[:group]).to eq('party')
  end

  it 'does not accept bad group group' do
    expect do
      resource[:group] = 'party crasher'
    end.to raise_error(Puppet::Error, %r{party crasher is not a valid group name})
  end
end
