(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"./src/client/entry.coffee":[function(require,module,exports){
var CalCtrl, app;

app = angular.module('calApp', []);

app.controller('calCtrl', CalCtrl = (function() {
  function CalCtrl() {
    this.days = ['Monday', 'Tuesday', 'Wednesday'];
  }

  return CalCtrl;

})());



},{}]},{},["./src/client/entry.coffee"])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvbmF0aGFuL3NlaW5mZWxkL3NyYy9jbGllbnQvZW50cnkuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsSUFBQSxZQUFBOztBQUFBLEdBQUEsR0FBTSxPQUFPLENBQUMsTUFBUixDQUFlLFFBQWYsRUFBeUIsRUFBekIsQ0FBTixDQUFBOztBQUFBLEdBRUcsQ0FBQyxVQUFKLENBQWUsU0FBZixFQUFnQztBQUNqQixFQUFBLGlCQUFBLEdBQUE7QUFDWCxJQUFBLElBQUMsQ0FBQSxJQUFELEdBQVEsQ0FBQyxRQUFELEVBQVcsU0FBWCxFQUFzQixXQUF0QixDQUFSLENBRFc7RUFBQSxDQUFiOztpQkFBQTs7SUFERixDQUZBLENBQUEiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiYXBwID0gYW5ndWxhci5tb2R1bGUgJ2NhbEFwcCcsIFtdXG5cbmFwcC5jb250cm9sbGVyICdjYWxDdHJsJywgY2xhc3MgQ2FsQ3RybFxuICBjb25zdHJ1Y3RvcjogLT5cbiAgICBAZGF5cyA9IFsnTW9uZGF5JywgJ1R1ZXNkYXknLCAnV2VkbmVzZGF5J11cbiJdfQ==
