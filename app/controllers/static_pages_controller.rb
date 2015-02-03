require './lib/mailchimp.rb'

class StaticPagesController < ApplicationController
  before_action :admin_user, only: :backend
  before_action :signed_and_primed, only: :home
	
  def home
    members_of_the_week = User.where('member_of_the_week IS TRUE').order('created_at DESC')
    members_of_the_week[0].nil? ? @first_member = User.all.first : @first_member = members_of_the_week[0]
    @weekly_award = @first_member.weekly_awards.last
  end

  def greetings
    @ateam = User.where(role_type: "ateam").order('name ASC')
    @exec = User.where(role_type: "exec").order('name ASC')
  end

  def sponsors
    send_file( "#{Rails.root}/app/assets/pdfs/sponsorship_packet.pdf",
    :disposition => 'inline',
    :type => 'application/pdf',
    :x_sendfile => true )
  end

  def email_signup
    if validates_email(params[:email])
      signup_to_mailing_list(params[:email])
      flash[:success] = 'Thank you for signing up!'
    else
      flash[:error] = 'Sorry, that is not a valid email'
    end
    redirect_to greetings_url
  end

  def about
    flash[:warning] = 'Our organization info has moved to the greeting page.'
    redirect_to greetings_url
    # @teams = Team.all
  end

  def contact
    flash[:warning] = 'Team leader information has moved to the greeting page.'
    redirect_to greetings_url
    # @ateam = User.where(role_type: "ateam").order('name ASC')
    # @exec = User.where(role_type: "exec").order('name ASC')
  end

  def backend

  end

  private

    def signed_and_primed
      unless signed_in?
        redirect_to greetings_url
      end
    end

    def signup_to_mailing_list(email)
      mailchimp = Mailchimp.new
      binding.pry
      begin
        mailchimp.subscribe_to_sponsors(email)
      rescue Gibbon::MailChimpError => e
        puts e
      end
    end

    def validates_email(email)
      if /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i =~ email
        return true
      else
        return false
      end
    end
end
