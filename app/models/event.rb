class Event < ActiveRecord::Base
    
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
 
def as_json(options = {})

      if @current_user == nil
         {
          :title => User.find(self.user_id).username,
          :id => self.id,
          #:title => self.title,
          #:description => self.description || "",
          :description => "description",
          :start => starts_at.rfc822,
          :end => ends_at.rfc822,
          :allDay => self.all_day,
          :recurring => false,
          :url => Rails.application.routes.url_helpers.event_path(id)
         }
      elsif @current_provider == nil
         {
          :title => Provider.find(self.provider_id).pname,
          :id => self.id,
          #:title => self.title,
          #:description => self.description || "",
          :description => "description",
          :start => starts_at.rfc822,
          :end => ends_at.rfc822,
          :allDay => self.all_day,
          :recurring => false,
          :url => Rails.application.routes.url_helpers.event_path(id)
    }
      end 
    
  end




  # def as_json(options = {})
   
  #   {
  #     :id => self.id,
  #     if @current_user
  #        ownername = Provider.find(self.provider_id).pname,
  #     elsif @current_provider
  #        ownername = User.find(self.user_id).username,
  #     end 
  #     :title => ownername,
  #     #:title => self.title,
  #     #:description => self.description || "",
  #     :description => "description",
  #     :start => starts_at.rfc822,
  #     :end => ends_at.rfc822,
  #     :allDay => self.all_day,
  #     :recurring => false,
  #     :url => Rails.application.routes.url_helpers.event_path(id)
  #   }
    
  # end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
