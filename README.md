# SwiftuiCoins

######Crypto updates app where user can get live crypto coins price

##Things which were taken care while making this project
  
###### It is made sure that data between screens are in sync and it was achieved by right uses of publishers and subscribers
###### It is made sure that all the view models of the screens, in their methods have weak reference on class so that the user's RAM is used efficiently
###### Also caching is implemented in an app, so that user don't need to download the data again and again in a single user session
###### List that contains navigation link, by nature calls initializer of the views where the list item will navigate to and if the view model of that view contains api call then, those api calls are made unnecessarily even view is not still navigated and so considering all these things data based navigation is used so unncessar initializers of views and their view model's unnecessary api calls can be avoided.
###### Also to make sure that app can be user friendly in both the dark and light mode, custom color sets are used
###### Concept of path is used efficiently to display the price chart of last 7 days for the coin

## Find the snaps of the app made here

######> Launch screen when app gets launched

![LaunchScreen](https://user-images.githubusercontent.com/68719677/218955494-85ecf5e5-90f9-4ff7-8d53-889b6ed5eba6.gif)

######> Search feature in appeared lists of coins, debounce is used so that network call is made only when user stops typing

![SearchFeature](https://user-images.githubusercontent.com/68719677/218956578-ca7e0bc5-50d6-49f7-97de-48244f31434c.gif)

######> Detail View for coins which displays last 7 days' price in a chart form which was made using path concept of swiftui, apart from that current price, market cap, 24h high and low prices etc are shown.

![CoinDetailsScreen](https://user-images.githubusercontent.com/68719677/218957669-9c0beeff-1b37-475f-9320-701a18263bfd.gif)

######> Uder can buy coin, data will be stored locally. As app was made for learning purposes, no database is included as of now. But while expanding app we can follow the rules/regulation and we can really allocate a real coin to user. But it is not in my plan as of now. 

![AddingCoin](https://user-images.githubusercontent.com/68719677/218961424-bc3234a4-1063-427b-a55f-cbfa81dc308f.gif)


