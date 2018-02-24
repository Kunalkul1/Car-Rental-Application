namespace :booking do
  desc "Change status to Available after time limit is exceeded."
  task :checking_status => :environment do
    Booking.checking_status
  end
end