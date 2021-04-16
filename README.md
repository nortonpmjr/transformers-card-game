# transformers-card-game

# How To Run

## Install cocoapods

CocoaPods is built with Ruby and is installable with the default Ruby available on macOS. We recommend you use the default ruby.
Using the default Ruby install can require you to use sudo when installing gems. Further installation instructions are in the guides.

$ sudo gem install cocoapods

Reference URL: https://cocoapods.org

## Install pods

Open a terminal and navigate to the project folder, and run the following commands

`pod deintegrate`

`pod install`

It will install the dependencies, now you can open the workspace file or type `xed .` in the terminal and run the project


## Known Technical Debts

* Add Keychain to save the JWT
* UI Test
* Unit Test the view controllers
* Unit Test the repository class

## Assumptions

The UI was made simple by purpose, the focus here was on architecture and organizing the data.
Some dependencies can be remove if needed, given proper time to replace them.
