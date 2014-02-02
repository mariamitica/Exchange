require 'eu_central_bank'
class EuCentralBank < Money::Bank::VariableExchange
  alias_method :exchange_float, :exchange
  alias_method :exchange_with_float, :exchange_with
  def exchange_float(cents, from_currency, to_currency)
    exchange_with_float(Money.new(cents, from_currency), to_currency)
  end
  def exchange_with_float(from, to_currency)
    Money.infinite_precision = true
    rate = get_rate(from.currency, to_currency)
    unless rate
      from_base_rate, to_base_rate = nil, nil
      @mutex.synchronize {
        from_base_rate = get_rate("EUR", from.currency, :without_mutex => true)
        to_base_rate = get_rate("EUR", to_currency, :without_mutex => true)
      }
      rate = to_base_rate / from_base_rate
    end
    ((Money::Currency.wrap(to_currency).subunit_to_unit.to_f / from.currency.subunit_to_unit.to_f) * from.cents.to_f * rate).round(2)
  end
end