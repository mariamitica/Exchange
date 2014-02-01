class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_rates

  protected
  def get_rates
    @eu_bank = EuCentralBank.new
    @cache = "public/exchange_rates.xml"
    @eu_bank.update_rates(@cache)
    if !@eu_bank.rates_updated_at || @eu_bank.rates_updated_at < Time.now - 1.days
      print 'here'
      @eu_bank.save_rates(@cache)
    end
  end
end
