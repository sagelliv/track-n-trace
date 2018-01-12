class PilCrawler
  BASE_URL = 'https://www.pilship.com/shared/ajax/?'.freeze
  PLACE_REGEX = %r{<b>(.*) \[.*\]<\/b>}

  def initialize(bl_number, agent = Mechanize.new)
    @agent = agent
    @bl_number = bl_number
  end

  def extracted_attrs
    return { detail: 'invalid B/L number.' } unless valid?

    {
      booking: extracted_booking,
      containers: extracted_containers
    }
  end

  def errors
    {
      status: '422',
      title: 'Invalid B/L number',
      detail: 'Invalid B/L number.',
      source: { pointer: 'data/attributes/bl_number' }
    }
  end

  def valid?
    json_data['err'] != 1
  end

  private

  def extracted_booking
    origin, destination = booking_place
    {
      bl_number: @bl_number,
      steamship_line: 'pil',
      origin: origin,
      destination: destination,
      vessel: delivery('.vessel-voyage').first,
      voyage: delivery('.vessel-voyage').second,
      vessel_eta: Date.parse(delivery('.arrival-delivery').second)
    }
  end

  def extracted_containers
    containers.map do |container|
      data = container.css('table td').map(&:text)
      {
        size:   data.second[0..1] + "'",
        container_type:   data.second[2..-1],
        number: data.first.split(' ').first
      }
    end
  end

  def delivery(selector)
    @delivery ||= Nokogiri::HTML(json_data['scheduletable'])
    @delivery
      .search('tr').last
      .css(selector)
      .children
      .map(&:text)
      .reject(&:empty?)
  end

  def booking_place
    json_data['scheduleinfo'].split("<br \/>")[0..1].map do |place|
      PLACE_REGEX.match(place)[1].capitalize
    end
  end

  def containers
    @containers ||= Nokogiri::HTML(json_data['containers']).search('.resultrow')
  end

  def json_data
    @json_response ||= JSON.parse(
      @agent.get(booking_url).content[3..-1]
    )['data']
  end

  def booking_url
    BASE_URL + [
      'fn=get_tracktrace_bl',
      'ref_num=' + @bl_number,
      '_=' + DateTime.now.strftime('%Q')
    ].join('&')
  end
end
