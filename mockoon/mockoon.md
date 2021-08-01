# Setting up Mockoon

## Installation

### macOS
* Download the installer from the [Mockoon website](https://mockoon.com/)
* In the Terminal, run `brew cask install mockoon`

### Windows
* Download the installer from the [Mockoon website](https://mockoon.com/)
* On the command line, run `choco install mockoon`

## Setting up an environment
1. Click the hamburger menu in the top-left corner
2. Click the blue plus icon to create a new environment
3. Click the hamburger menu again OR somewhere else in the application to close the environment menu
4. You can click "New environment" to change the name of the environment

*For this project, please make sure you set your port to 3001. To set the port, change the number at the top of the screen after 0.0.0.0:*

## Setting up a route
1. Below the environment start button (the green play button), click the blue plus icon to create a new route
   1. When you create a new environment, a blank route is automatically created
2. In the second row, you can set what REST method is used for this route
3. After the forward-slash following the REST method, you can set the path of the route
4. You can add a description of the route below the path; this will show under the route path in the route list
5. Below that, you can create a number of different HTTP responses
6. You can either include a JSON file in the File tab, or you can go to the Body text area to write the JSON out there

## Starting an environment
1. Confirm you are looking at the environment page for the environment you'd like to run
2. Click the green play button next to the environment name to start the environment

Putting a route into your browser should show the JSON response. For example, if your port was 3001 and your route was /account, you could go to `localhost:3001/account`.

## Exporting an environment
1. Right click on the environment you wish to export
2. Click on `Copy to clipboard (JSON)`
3. Paste the JSON in the repo's file *(in business_banking, this is `flutter_clean_architecture_financial_app/mockoon/flutter_clean_architecture_financial_app_env.json`*

## Importing an environment

### From clipboard
1. Copy the environment JSON object
2. In Mockoon, click on `Import/export` in the menu bar
3. Go to `Mockoon's format`
4. Click on `Import from clipboard`

### From file
1. In Mockoon, click on `Import/export` in the menu bar
2. Go to `Mockoon's format`
3. Click on `Import from a file (JSON)`
4. Select and open the JSON file containing the environment JSON