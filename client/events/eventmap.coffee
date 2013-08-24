##### Helpers for event map #####

# need to prefix with @ sign to exports the variable to client global space.
@okCancelEvents = (selector, callbacks) ->
  ok = callbacks.ok || ->
  cancel = callbacks.cancel || ->

  evtname = "keyup #{selector}, keydown #{selector}, focusout #{selector}"
  console.log "okCancelEvents : ", evtname
  eventmap = {}    # 
  eventmap[evtname] = (evt) ->
    if evt.type is "keydown" and evt.which is 27
      cancel.call this, evt
    else if evt.type is "keyup" and evt.which is 13 or evt.type is "focusout"
      value = String evt.target.value || ""
      if value
        ok.call this, value, evt
      else
        cancel.call this, evt
  
  eventmap

# Returns an event_map key for attaching "ok/cancel" events to
# a text input (given by selector)
okcancel_events = (selector) -> 
  "keyup #{selector}, keydown #{selector}, focusout #{selector}"
