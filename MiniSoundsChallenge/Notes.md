#  Notes TODO

- Move Model Structs to their own file
- Create HomeView with a ConfigLoadingViewModel and ListenPageFactory() 
    //TODO: Use Buttons instead and fire an action on ConfigLoadingViewModel called loadConfig(url: YourURL for each button here)
    //TODO: Create an if here, if viewModel.configLoaded then show your listenPageFactory() if not show your buttons or an error message
    //TODO: Your config view model should talk to the network and load the config then update the viewModel's published configLoaded property
    //TODO: You should then be able to remove setupConfigJSON from your ListenPageViewModel
    
- See comments in HomeView - Don't create views and view models in your views. Use factories to configure from the outside like we do in the BrandPage
- See comments in playback service and config service - You can make them more testable and more maintainable by extracting the access to external services into repositories.
This is what the hexaganol pattern is all about, creating a layer of adaption between your external services and your business logic so that you can change the external services out in the future.

