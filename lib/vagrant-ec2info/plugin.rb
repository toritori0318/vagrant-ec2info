module VagrantPlugins
  module Ec2info
    class Plugin < Vagrant.plugin("2")
      name "EC2 Metadata"
      description <<-DESC
      Describe your ec2 server..
      DESC

      command("ec2info") do
        require File.expand_path("../command.rb", __FILE__)
        Command
      end

    end
  end
end
