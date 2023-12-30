# Setup Steps
* Create a new game in Roblox studio, or open an existing project
    * Recomended : use Rojo to sync this project's files into your editor from VS code
* Install Roact https://github.com/Roblox/Roact/releases . Copy the package to Replicated Storage
* Enable HTTP Requests
    * Go to File => Game Settings -> Security => Enable HTTP Requests
* Include API Key
    * Go to https://bloxyops.com/game
    * Copy your developer token
    * Find a property in ServerScriptService/Server/RobloxLiveOps. Add a attribute ApiKey : YOUR_KEY

Run the game