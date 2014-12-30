require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.disable_sudo = true
  c.path  = "/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin"
  c.host  = ENV['TARGET_HOST']
  options = Net::SSH::Config.for(c.host)
  user    = options[:user] || Etc.getlogin
  c.ssh   = Net::SSH.start(c.host, user, options)
  c.os    = backend.check_os

  tags = (ENV['TARGET_TAGS'] || "").split(",")
  c.filter_run_excluding :tag => lambda { |t|
    not tags.include?(t)
  }
end
