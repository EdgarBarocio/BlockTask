# BlockTask

## Architecture

This project uses MVVM to separate functionality from the main views and move all business logic to the view models
This also makes mocking of the service calls easier, as the dependency is injected on initialization of the view model

## Trade offs
UI was built using interface builder, this was to save time in the creation of views.
No landscape orientation is supported, nor is iPad. This to focus on data handling rather than UI work.
No tests on the Views were created, automated UI tests would be ideal. 

## Running the project
Just build and run. No extra steps needed.
To change endpoints and use the Malformed endpoint or the Empty endpoing on `StocksViewModel` Line: 29

change
```
NetworkConstants.portfolioEndpoint
```

and use:

Malformed endpoint:
```
NetworkConstants.malformedEndpoint
```
Empty endpoint:
```
NetworkConstants.emptyEndpoint
```

## 3rd Party libraries or copied code
The implementation of the background view found in: `StocksViewController` and the formatters found in `StockCellsViewModel` were found in Stackoverflow
No third party libraries are used.

## Potential future work
Better UI formatting. Currently the cells are Main Text and Detail Text. Maybe not all info is needed at the cell level.
Navigation. The application is currently build using storyboards and the landing page is embedded in a navigation controller in case Navigation is a future feature