module StatisticsHelper

  def format_date(dates)
    dates.map { |date| DateTime.parse(date).strftime("%d/%m/%Y")}
  end

end