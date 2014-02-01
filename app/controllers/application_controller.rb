class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_rates

  protected
  def get_rates
    @eu_bank = EuCentralBank.new
    @cache = "public/exchange_rates.xml"
    if File.exists?(@cache)
      file = Nokogiri::XML(open(@cache))
      unless Date.parse(file.css('Cube Cube')[0]['time']) > Date.today - 1.days
        @eu_bank.save_rates(@cache)
      end
    else
      @eu_bank.save_rates(@cache)
    end
    @eu_bank.update_rates(@cache)
  end
end
