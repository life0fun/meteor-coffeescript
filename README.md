# Meteor todos with Coffeescript

This is an exmaple to show how to use Coffeescript with latest Meteor (>0.6.5).
The reason for this project is because I could not find good document of coffeescript in Meteor, and all example projects using coffeescript are broken at the time when I created this project.

The project was original taken from 
  https://github.com/swombat/meteor-todos-coffeescript


## Dependency and Usage
  Module/package depdency is clearly identified in .meteor/packages and smart.json
  1. make sure standard-app-packages is included in .meteor/packages
  2. mrt add iron-router will add to both .meteor/packages and smart.json
  3. mrt remove autopublish to remove from .meteor/packages

## File load sequence.
  1. files in project home lib/, 
  2. files from the deepest folder
  3. alphabetic when in the same level.

## expose variables in coffeescript file module to global space.
  Prepend @ sign to the variable you want to expose. @ will make it global.


