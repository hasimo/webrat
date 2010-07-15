require "webrat/selenium/application_servers/base"

module Webrat
  module Selenium
    module ApplicationServers
      class Rails < Webrat::Selenium::ApplicationServers::Base

        def start
          system start_command
        end

        def stop
          silence_stream(STDOUT) do
            system stop_command
          end
        end

        def fail
          $stderr.puts
          $stderr.puts
          $stderr.puts "==> Failed to boot the Rails application server... exiting!"
          $stderr.puts
          $stderr.puts "Verify you can start a Rails server on port #{Webrat.configuration.application_port} with the following command:"
          $stderr.puts
          $stderr.puts "    #{start_command}"
          exit
        end

        def pid_file
          prepare_pid_file("#{RAILS_ROOT}/tmp/pids", "mongrel_selenium.pid")
        end

        def server_script
          Rails.version.to_f >= 3.0 ? "#{RAILS_ROOT}/script/rails server" : "#{RAILS_ROOT}/script/server" 
        end

        def start_comman
          "#{server_script} --port #{Webrat.configuration.application_port} -e #{Webrat.configuration.application_environment} --pid #{pid_file} &"
        end

        def stop_command
          "kill -KILL `cat #{pid_file}`"
        end
      end
    end
  end
end
