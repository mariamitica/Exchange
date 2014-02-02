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
    if (/^(\$)?((\d+)|(\d{1,3})(\,\d{3})*)(\.\d+)?$/).match(params[:amount])
      @result = @eu_bank.exchange_float(params[:amount].gsub(',',''), params[:original_currency], params[:destination_currency])
      respond_to do |format|
        format.js
      end
    end
  end
end