#  Notes TODO

- Move Model Structs to their own file
- Create HomeView with a ConfigLoadingViewModel and ListenPageFactory() 
    //TODO: Use Buttons instead and fire an action on ConfigLoadingViewModel called loadConfig(url: YourURL for each button here)
    //TODO: Create an if here, if viewModel.configLoaded then show your listenPageFactory() if not show your buttons or an error message
    //TODO: Your config view model should talk to the network and load the config then update the viewModel's published configLoaded property
    //TODO: You should then be able to remove setupConfigJSON from your ListenPageViewModel
