class ReservationMailerPreview < ActionMailer::Preview
  def reservation_email
    ReservationMailer.reservation_email(Reservation.last)
  end
end
