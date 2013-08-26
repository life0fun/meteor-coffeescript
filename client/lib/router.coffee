
# by default, Router takes over rendering the body of the page.
# the name of the route is also the name of the template, and the NameController.
# 
# Router.map ->                                                                          
#   @route 'main', path: '/'                                                             
#   @route 'list', path: '/:_id', action: "customAction"                                                                       

 
# by default, template pointed by the route will be render directly into body.
# You can also share nav, side, footer templates, inside the main layout template.
# router will then render all named templates into all yields named templates.
# Router.configure layout: 'layout'                                                      
                                                                                       
# # each route managed by a controller. route 'name' searches for NameController
# class @MainController extends RouteController
#   #template: 'todos'
                                                                                       
#   renderTemplates:
#     'tag_filter': to: 'tag_filter'
#     'side-pane': to: 'lists'
#     'main-pane': to: 'todos'
                                                                                       
#   run: ->
#     console.log 'running'
#     super

# # show list controller
# class @ListController extends RouteController
#   template: 'todos'
                                                                                       
#   renderTemplates:
#     'tag_filter': to: 'tag_filter'
#     'side-pane': to: 'lists'
#     'main-pane': to: 'todos'
                                                                                       
#   run: ->
#     console.log 'running'
#     super