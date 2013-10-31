require "pathname"

require "vagrant/action/builder"
require "vagrant-aws/action"

module VagrantPlugins
  module Ec2info
    module Action
      # Include the built-in modules so we can use them as top-level things.
      include Vagrant::Action::Builtin

      def self.action_info
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use VagrantPlugins::AWS::Action::ConnectAWS
          b.use Info
        end
      end

      # The autoload farm
      action_root = Pathname.new(File.expand_path("../action", __FILE__))
      autoload :Info, action_root.join("info")
    end
  end
end
