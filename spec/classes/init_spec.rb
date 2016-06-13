require 'spec_helper'
describe 'wls' do
  context 'with default values for all parameters' do
    it { should contain_class('wls') }
  end
end
