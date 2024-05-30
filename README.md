# Awesome Movies

Simple SwiftUI project based on TMDB API

## Description

Awesome movies fetches movies from TMDB API and displays on home screen based:

* Top rate
* Now playing
* Popular
* Upcoming

Users can scroll through different categories and select any movie to see the detail Screen. 
In Movie detail screen it's possible to save the movie. Movie will be save to Coredata

You can view saved movies in Downloads tab. You can delete any saved movie from Downloads Screen by swipe to delete action or by taping on the movie to go to Movie Detail Screen and tap the delete button on the top right corner.

## Getting Started

To be able to run the project you have to register with the themoviedb.org and get your Bearar token. 
Follow the instructions to register and get your Bearar token. https://developer.themoviedb.org/docs/getting-started 



### Dependencies


* iOS 17.0
* TMDB Bearar Token


### Executing program

* Api class
* beararToken 
```
fileprivate let beararToken: String = "Your bearar token here"
```



## Help

* There's some issue with xcode indexing if you download the project from github and try to run
you might get error that the xcmodel is not available at the path. You can right click on the xcdatamodel show in finder from xcode remove the file reference drag and drop the xcmodel again to the project it will detect it.

* After adding the model file again you can do shift+cmd+k which does a clean build and everything should work as expect

* If bearar token is not provided the app will crash with a fatalError message to console


## Author

* Khalid Afridi
* https://www.linkedin.com/in/afridikhalid/

## Version History

* 1.0
