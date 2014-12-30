require 'spec_helper'

describe package('postgresql-8.4') do
  it { should be_installed }
end

describe service('postgresql-8.4') do
  it { should be_enabled   }
  it { should be_running   }
end
