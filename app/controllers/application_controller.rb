class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_rates

  protected
  def get_rates
    @eu_bank = EuCentralBank.new
    @cache = "public/exchange_rates.xml"
    unless File.exists?(@cache)
      @eu_bank.save_rates(@cache)
    else
      file = Nokogiri::XML(open(@cache))
      unless Date.parse(file.css('Cube Cube')[0]['time']) > Date.today - 1.days && #.tap {|doc| doc.xpath('gesmes:Envelope/xmlns:Cube/xmlns:Cube//xmlns:Cube') }
        @eu_bank.save_rates(@cache)
      end
    end
    @eu_bank.update_rates(@cache)
  end
end
