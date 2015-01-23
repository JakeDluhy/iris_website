# class Calendar
#   CLIENT_ID = "153901107244-5kbub52bgd7c156qj833cgla99nlhsnb.apps.googleusercontent.com"
#   CLIENT_SECRET = "P5PG8nR83eoOmQPihmdKmH29"
#   CALENDAR_ID = "iris.uiuc@gmail.com"

#   def initialize
#     @cal = Google::Calendar.new(:client_id     => CLIENT_ID, 
#                                 :client_secret => CLIENT_SECRET,
#                                 :calendar      => CALENDAR_ID,
#                                 :redirect_url  => "urn:ietf:wg:oauth:2.0:oob" # this is what Google uses for 'applications'
#                                 )
#   end

#   def get_events
#     return @cal.events
#   end
# end