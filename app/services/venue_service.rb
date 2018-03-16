require 'json'

class VenueService
  def fetch_cities
    fetch_venues('cities')
  end

  def fetch_districts(city_id)
    fetch_venues('districts', city_id)
  end

  def fetch_wards(district_id)
    fetch_venues('wards', district_id)
  end

  private

  def fetch_venues(type, parent_id = nil)
    default_option = {
      cities: 'Chọn Tỉnh/Thành phố',
      districts: 'Chọn Quận/Huyện',
      wards: 'Chọn Phường/Xã'
    }

    result = { default_option[type.to_sym] => 0 }
    venues = File.read("#{Rails.root}/lib/assets/#{type}.json")
    venues_hash = JSON.parse(venues)
    venues_hash = venues_hash.select { |_code, venue| venue['parent_code'] == parent_id.to_s } if parent_id
    venues_hash.each { |code, venue| result[venue['name_with_type']] = code }
    result
  end
end