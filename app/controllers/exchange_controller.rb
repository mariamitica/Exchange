class ExchangeController < ApplicationController

  def index
    get_currencies
  end

  def get_currencies
    @currencies = []
    @eu_bank.rates.keys().each do |k|
      @currencies.push(k.split('EUR_TO_')[1])
    end
  end

  def convert
    @eu_bank = EuCentralBank.new
    @eu_bank.update_rates("public/exchange_rates.xml")
    if params[:amount].present?
      @result = @eu_bank.exchange(params[:amount], params[:original_currency], params[:destination_currency])
      respond_to do |format|
        format.js
      end
    end
  end
end