class API::Mailchimp
  MAILING_LIST_ID = "77bc6731c9"

  def initialize
    @gb = Gibbon::API.new('356819224db1b541568200d055dd8f3c-us8')
  end

  def subscribe(email, name)
    data = {
      :id => MAILING_LIST_ID,
      :email => { :email => email },
      :merge_vars => {
        :FNAME => name.split[0],
        :LNAME => name.split[1]
      },
      :double_optin => false,
      :send_welcome => true
    }
    @gb.lists.subscribe(data)
  end

  def unsubscribe(email, delete = true)
    data = {
      :id => MAILING_LIST_ID,
      :email => { :email => email },
      :delete_member => delete
    }
    @gb.lists.unsubscribe(data)
  end

  def create_segment(name)
    data = {
      :id => MAILING_LIST_ID,
      :name => name
    }
    response = @gb.lists.static_segment_add(data)
    return response["id"]
  end

  def delete_segment(seg_id)
    data = {
      :id => MAILING_LIST_ID,
      :seg_id => seg_id
    }
    @gb.lists.static_segment_del(data)
  end

  def subscribe_member_to_segment(seg_id, email)
    data = {
      :id => MAILING_LIST_ID,
      :seg_id => seg_id,
      :batch => [
        { :email => email }
      ]
    }
    @gb.lists.static_segment_members_add(data)
  end

  def unsubscribe_member_from_segment(seg_id, email)
    data = {
      :id => MAILING_LIST_ID,
      :seg_id => seg_id,
      :batch => [
        { :email => email }
      ]
    }
    @gb.lists.static_segment_members_del(data)
  end

  #Send out emails to everyone in the team email segment with the title, content, and pictures
  def send_out_emails(team_name, team_segment_id, author_name, title, content, picture_urls)
    team_name.nil? ? name = 'IRIS General Update' : name = team_name; segment_id = team_segment_id
    picture_urls.count > 3 ? num_pictures = 3 : num_pictures = picture_urls.count
    ac = ActionController::Base.new
    html = ac.render_to_string(
      :template => "email_templates/#{ num_pictures }_picture",
      :layout => false,
      :locals => {:title => title, :content => content, :team_name => name, :author_name => author_name, :picture_urls => picture_urls}
    )

    data = {
      :type => "regular",
      :options => {
        :list_id => MAILING_LIST_ID,
        :subject => "Update from #{name}",
        :from_email => 'dluhy2@illinois.edu',
        :from_name => 'IRIS Updates',
        :to_name => "*|TITLE:FNAME|*"
      },
      :content => {
        :html => html
      }
    }
    if !team_name.nil?
      data[:segment_opts] = {
        :match => "any",
        :conditions => [
          {
            :field => "static_segment",
            :op => "eq",
            :value => segment_id
          }
        ]
      }
    end

    response = @gb.campaigns.create(data)
    cid = response["id"]
    @gb.campaigns.send({:cid => cid})
  end
end