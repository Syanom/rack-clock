class Clock
  DATE_FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d' }.freeze
  TIME_FORMATS = { 'hour' => '%H', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(format)
    @format = format.split(',')
  end

  def valid?
    unknown_format.empty?
  end

  def unknown_format
    @format.difference(DATE_FORMATS.keys + TIME_FORMATS.keys)
  end

  def time
    date_format = @format.map { |k| DATE_FORMATS[k] }.compact.join('-')
    time_format = @format.map { |k| TIME_FORMATS[k] }.compact.join(':')
    Time.now.strftime("#{date_format} #{time_format}")
  end
end
