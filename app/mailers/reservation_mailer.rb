class ReservationMailer < ApplicationMailer
  def reservation_email(reservation)
    @reservation = reservation
    email = reservation.email
    restaurant_name = reservation.restaurant.name

    if email.present?
      mail(to: email,
           subject: "您在「#{restaurant_name}」的訂位已確認"
          )
    end
  end
end
