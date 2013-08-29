
# first, set up dom event handler, need to be outside rendered

searchHdl = 
  ok: (text, evt) ->
    console.log "Metrics searching ...", text
    Session.set 'search_metrics', text
    evt.target.value = ""
    Router.graphite()

evtmap = okCancelEvents "#search", searchHdl
Template.cubism.events evtmap

# the mapping of metrics keywords to real name
GaugePrefix = "stats.gauges.scale.vci-scale-core*."
TimerPrefix = "stats.timers.vci.scale.vci-scale-*.core.*."
GaugePrefixPro = "stats.gauges.production.vci-core*."
TimerPrefixPro = "stats.timers.VerizonCNI.production.vci-core-*.core.*."
MetricsMapping = 
  'cpu' : GaugePrefixPro + 'cpu.total.user'
  'diskspace' : GaugePrefixPro + 'diskspace.root.byte_free'
  'process' : GaugePrefixPro + 'loadavg.processes_total'
  'mem' : GaugePrefixPro + 'memory.MemFree'
  'hsasset' : TimerPrefixPro + 'getHistoryForAsset.mean'
  'hsquery': TimerPrefixPro + 'query.mean'
  'asset': TimerPrefixPro + 'getAssetById.mean'
  'kiln' : TimerPrefixPro + 'sendRequest.mean'


Template.cubism.rendered = ->
  console.log "cubism rendered is called :"
  # connect to graphite, step 10 seconds, 1440*10/60*60=4 hours
  context = cubism.context().step(6e4).size(1280)
  graphite = context.graphite "http://vci-lnm-metrics.locationlabs.com"
  
  metrics = [
    'stats.gauges.scale.vci-scale-core-api1.cpu.total.user',
    'stats.gauges.scale.vci-scale-core-event1.cpu.total.user',
    'stats.gauges.scale.vci-scale-core-event2.cpu.total.user',
  ]
  
  horizon = context.horizon().metric(graphite.metric).height(100)
  
  d3.select("#graphs").selectAll(".axis")
    .data(["bottom"])
    .enter().append("div")
    .attr("class", (d) -> return d + " axis")
    .each (d) -> d3.select(this).call(context.axis().ticks(12).orient(d))

  d3.select("#graphs").append("div")
    .attr("class", "axis")
    .call(context.axis().orient("top"));
 
  d3.select("#graphs").append("div")
    .attr("class", "rule")
    .call(context.rule());
 
  d3.select("#graphs").selectAll(".horizon")
    .data(metrics)
    .enter().append("div")
    .attr("class", "horizon")
    .call(horizon)


  sm = Session.get 'search_metrics'
  searchMetrics = sm ? MetricsMapping['cpu']
  searchMetrics = MetricsMapping[searchMetrics]
  console.log "searchMetrics =", searchMetrics

  graphite.find searchMetrics, (error, results) ->
    console.log "finding metrics :", error, results
    #metrics = metrics.concat results
    metrics = results
    console.log "concat metrics ", metrics

    # first, remove existing horizons
    d3.selectAll(".horizon").call(horizon.remove).remove()
    d3.select("#graphs").selectAll(".horizon")
      .data(metrics)
      .enter().append("div", ".bottom")
      .attr("class", "horizon")
      .call(horizon.format(d3.format("d")))

  context.on "focus", (i) ->
    # vright = if i is null then 0 else context.size() - i + "px"
    d3.selectAll(".value").style "left", i + "px"