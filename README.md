# LastFmClient

This app was made as test task for one of the companies

While working on it I revised my uderstanding of MVVM and Clean Architecture principles and tried apply them

## Task
Develop an iPhone-App in Swift for searching and storing music album information provided by the LastFM-API (similiar alternative APIs would be ok).

The app should contain the following screens:

#### main-screen

This screen shows all your locally stored albums presented in a UICollectionView. A tap on one of these albums opens a detail-page. The navigationBar contains a search-icon, which opens the search on tap.

#### search

It should be possible to search for artists and present the search results in a list. A selection of one list-item opens the albums-overview screen.

#### albums

List or collection of albums released by the selected artist. It should be possible to store (and delete stored) albums locally. Stored albums should be visibly marked. Tap on an album opens the detail-page.

At least the following informations should be stored:
* album name
* artist
* image or imageURL
* tracks

#### detail-page

Overview with detailed information (name, artist, tracks, etc.) about the album. Store and delete functionality.

### Requirements

* Latest Xcode-Version
* Latest Swift-Version
* iOS 10 or newer
* API communication in JSON-format CocoaPods integration with the following pods
* Alamofire
* AlamofireImage
* Use the Codable protocol to serialize the JSON. Alternatively you can use the following pods: ObjectMapper, AlamofireObjectMapper
* Preferred for storing/saving: CoreData or Realm

Optional
* UI and UX is fully up to you. Animations and gestures are not required, but nice to have. Feel free to be creative
