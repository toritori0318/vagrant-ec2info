require 'optparse'

module VagrantPlugins
  module Ec2info
    class Command < Vagrant.plugin("2", :command)
      def execute
        opts = OptionParser.new
        opts.banner = 'Usage: vagrant ec2info [vm_name]'
        argv = parse_options(opts)
        return if !argv

        with_target_vms(argv, :reverse => true) do |machine|
          if machine.provider_name.to_s == 'aws'
            @env.action_runner.run(VagrantPlugins::Ec2info::Action.action_info, {
              :machine => machine,
            })
          else
            puts "Skipping #{machine.name}: not aws provider"
            next
          end
        end
        0
      end

    end
  end
end
