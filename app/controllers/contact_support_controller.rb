class ContactSupportController < ApplicationController
  def new
  end

  def send_email
    title = params[:title]
    description = params[:description]

    SupportMailer.contact_support(title, description).deliver_now
    redirect_to root_path, notice: "Your support request has been sent successfully!"
  end
end
