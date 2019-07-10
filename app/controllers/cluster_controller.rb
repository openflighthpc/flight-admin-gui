class ClusterController < ApplicationController
  def index
    #BoltOns
    @vpn = {
      status: vpn_status,
      name: vpn_name
    }

    @content = appliance_information
  end

  private

  def appliance_information
    file = Rails.application.config.appliance_information
    file_data = IO.binread(file) if File.exist? file

    format_markdown(file_data)
  end

  def vpn_status
    run_global_script(ENV['VPN_STATUS'])[:status].success?
  end

  def vpn_name
    run_global_script(ENV['VPN_NAME'])[:output]
  end
end
