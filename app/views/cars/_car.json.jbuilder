json.extract! car, :id, :license_plate, :manufacturer, :model, :hourly_rental_rate, :style, :location, :status, :created_at, :updated_at
json.url car_url(car, format: :json)
