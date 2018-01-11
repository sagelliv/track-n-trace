require 'rails_helper'

describe PilCrawler do
  describe '#extract_booking' do
    it 'extracts all information for a given booking' do
      bl_number = 'TXG790214500'
      crawler = build_crawler(bl_number, file_fixture('pil_response.txt').read)

      attrs = crawler.extracted_attrs

      booking = attrs[:booking]
      expect(booking[:bl_number]).to eq(bl_number)
      expect(booking[:steamship_line]).to eq('pil')
      expect(booking[:origin]).to eq('Xingang')
      expect(booking[:destination]).to eq('Oakland')
      expect(booking[:vessel]).to eq('CSCL AUTUMN')
      expect(booking[:voyage]).to eq('VQC60007E')
      expect(booking[:vessel_eta]).to eq(Date.new(2017, 4, 19))

      expect(attrs[:containers]).to eq(
        [
          { size: "20'", container_type: 'GP', number: 'PCIU1857050' }
        ]
      )
    end

    it 'extracts all information for multiple containers' do
      bl_number = 'TXG790195400'
      crawler = build_crawler(
        bl_number, file_fixture('pil_multiple_containers_response.txt').read
      )

      attrs = crawler.extracted_attrs

      booking = attrs[:booking]
      expect(booking[:bl_number]).to eq(bl_number)
      expect(booking[:steamship_line]).to eq('pil')
      expect(booking[:origin]).to eq('Xingang')
      expect(booking[:destination]).to eq('Tamatave')
      expect(booking[:vessel]).to eq('KOTA NEKAD')
      expect(booking[:voyage]).to eq('KNKD0112W')
      expect(booking[:vessel_eta]).to eq(Date.new(2017, 5, 20))

      expect(attrs[:containers]).to eq(
        [
          { size: "40'", container_type: 'HC', number: 'DFSU6377844' },
          { size: "40'", container_type: 'HC', number: 'TEMU6187487' }
        ]
      )
    end
  end

  def build_crawler(bl_number, fixture)
    described_class.new(bl_number, PilAgent.new(fixture))
  end
end

class PilAgent
  def initialize(fixture)
    @fixture = fixture
  end

  def get(_)
    self
  end

  def content
    'XXX' + @fixture
  end
end
