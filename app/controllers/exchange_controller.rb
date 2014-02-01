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
    if (/^(\$)?((\d+)|(\d{1,3})(\,\d{3})*)(\.\d{1,})?$/).match(params[:amount])
      original_exchange_rate = @file.css('Cube Cube Cube').select{|p| p['currency'] ===  params[:original_currency]}[0]['rate']
      destination_exchane_rate = @file.css('Cube Cube Cube').select{|p| p['currency'] ===  params[:destination_currency]}[0]['rate']
      @result = (params[:amount].gsub(',','').to_f * destination_exchane_rate.to_f / original_exchange_rate.to_f).round(2)
      #@result = @eu_bank.exchange(params[:amount], params[:original_currency], params[:destination_currency])
      respond_to do |format|
        format.js
      end
    end
  end
end