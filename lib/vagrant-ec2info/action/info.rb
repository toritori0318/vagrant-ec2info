module VagrantPlugins
  module Ec2info
    module Action
      # This runs the configured instance.
      class Info
        include Vagrant::Util::Retryable

        def initialize(app, env)
        end

        def call(env)
            server = env[:aws_compute].servers.get(env[:machine].id)
            puts "[#{env[:machine].name}] Instance infomation."
            begin
              puts "[#{env[:machine].name}]  -- Instance ID: #{server.id}"
              puts "[#{env[:machine].name}]  -- Type: #{server.flavor_id}"
              puts "[#{env[:machine].name}]  -- AMI: #{server.image_id}"
              puts "[#{env[:machine].name}]  -- Region: #{env[:aws_compute].region}"
              puts "[#{env[:machine].name}]  -- Availability Zone: #{server.availability_zone}"
              puts "[#{env[:machine].name}]  -- Keypair: #{server.key_name}"
              puts "[#{env[:machine].name}]  -- Security Groups: #{server.security_group_ids}"
              puts "[#{env[:machine].name}]  -- Private IP: #{server.private_ip_address}"
              puts "[#{env[:machine].name}]  -- Private DNS: #{server.private_dns_name}"
              puts "[#{env[:machine].name}]  -- Public IP: #{server.public_ip_address}"
              puts "[#{env[:machine].name}]  -- Public DNS: #{server.dns_name}"
              puts "[#{env[:machine].name}]  -- Status: #{server.state}"
              puts "[#{env[:machine].name}]  -- Launch Time: #{server.created_at}"
              if server.vpc_id
                puts "[#{env[:machine].name}]  -- Vpc ID: #{server.vpc_id}"
                puts "[#{env[:machine].name}]  -- Subnet ID: #{server.subnet_id}"
              end

              tags = server.tags.to_hash || {}
              if !tags.empty?
                puts "[#{env[:machine].name}]  -- Tags:"
                tags.keys().each do |key|
                  puts "[#{env[:machine].name}]       #{key}:#{tags[key]}"
                end
              end

            rescue Excon::Errors::BadRequest => e
              raise
            end
        end
      end
    end
  end
end
