# Meteor todos with Coffeescript

This is an exmaple to show how to use Coffeescript with latest Meteor (>0.6.5).

The reason for this project is because I could not find good document of coffeescript in Meteor, and all example projects using coffeescript are broken at the time when I created this project.


## Dependency and Usage

install or upgrade to latest meteor 0.6.5.
    curl https://install.meteor.com | /bin/sh
    meteor update

install meteorite.
    npm install -g meteorite

Module/package depdency is defined in .meteor/packages and smart.json
  1. make sure standard-app-packages is included in .meteor/packages
  2. mrt add iron-router will add to both .meteor/packages and smart.json
  3. mrt remove autopublish to remove from .meteor/packages

## EventMap
  1. Template.tmplname.events is fn that takes event map of evt type to evt handler.
  2. $ -> is $(function(){}); === jQuery(document).ready(function(){}), so the fn will be invoke upon doc ready. check jquery ready doc for details.

## File load sequence.
  1. files in project home lib/
  2. files from the deepest folder, files in sub dir are loaded first.
  3. alphabetic when in the same level.
  4. files that match main.* are loaded after everything else.

## Coffeescript variable scope
  1. coffeescript vars are file-scoped, or module scoped.
  
  2. To expose variables in coffeescript file module to global space, just prepend @ symbol to the variable you want to expose. @ symbol will decorate global variables.
  
  3. Meteor has global share object for module to attach global variables.
    __coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;

## Google map canvas
  1. need to give google map canvas div height and width size in css. Otherwise somehow the computed height of map canvas height is 0 that makes map canvas not visible.
  2. ensure google maps API loaded first and then run meteor script to render your template. Render map canvas template in Template.rendered callback. You can also use the .created method instead of .rendered to perform tasks only once 


