$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	$('#calendar').fullCalendar({
        minTime: 1,
        maxTime: 20,
        ignoreTimezone: true,    
// dayClick
		  dayClick: function(date, allDay, jsEvent, view) {

        if (allDay) {
            // Clicked on the entire day
            $('#calendar')
                .fullCalendar('changeView', 'agendaDay'/* or 'basicDay' */)
                .fullCalendar('gotoDate',
                    date.getFullYear(), date.getMonth(), date.getDate());
        
        }
    },
//

//
    editable: true,        
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 500,
        slotMinutes: 15,

        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },
        
        // a future calendar might have many sources.        
        eventSources: [{
            //url: '/events',
            // url: '/users/1/events',
            url: '/users/events',
            //url: '/users/' + gon.current_user_id + '/events',
            color: 'yellow',
            textColor: 'black',
            allDay: false,
            ignoreTimezone: true   
        }],
        
        timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5",
        
        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        },
	});
});

function updateEvent(the_event) {
    $.update(
      "/events/" + the_event.id,
      { event: { title: the_event.title,
                 starts_at: "" + the_event.start,
                 ends_at: "" + the_event.end,
                 description: the_event.description
               }
      },
      function (reponse) { alert('successfully updated task.'); }
    );
};