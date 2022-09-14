# Recruitment process - development description
- time: 6 hours

I've implemented this task in the simplest way to show my skills and approach to basic rules.

I've read from gpx file:
- averageSpeed - to present in cell and show How I convert, format and handle dependecies. 
- coordinates - to present in the mapView. 

I've made FilesViewController agnostic of data, which is not presented and MapViewController agnostic of data, which is not needed to display path in mapView. I achieved that by separating models per component.

I've created boundaries between classes by protocols - This fulfill rules like LSP and ISP.

I've added few tests to show how I test (async and sync tests) - Usually I use TDD approach and write Unit Tests and simple one Snapshot Test per VC to validate the app. 

What I would do when it would be real commercial application?
- I would add error handling. 
- I would make UI pretty.
- I would decouple GPXFileReader from GPX file details(elementName, keys) and inject mapper. 
- I would add possibility to add files by user.

What I would improve when app would have to handle a lot of gpx files?
- I would add reading only visible cells/files - and possibility to cancel this action. (performance)
- I would add pagination of files. (performance)

What I would improve first when app would growing in the complexity?
- I would create container of the dependencies.


