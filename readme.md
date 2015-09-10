#Readme

Running instructions:
To run the project correctly make sure you open the .xcworkspace file and NOT the .xcodeproj file

If for some reason building the project fails then you need to do this:

1)Open terminal then: cd <path-to-project>/project/ 

2)If you have cocopods installed  skip to step 3, otherwise type this into the terminal: sudo gem install cocoapods
If you encounter any problems during installation, please visit this guide:https://guides.cocoapods.org/using/troubleshooting#installing-cocoapods.

3)Enter this command in the terminal and wait for it to finish: pod install

4)To run the project correctly make sure you open the .xcworkspace file and NOT the .xcodeproj file

5)When Xcode opens the project make sure the target selected in the upper left corner is the target that would run the app and not the "Documentation" target which creates the documentation.

If you want to have Xcode display all my documentation in its right helpbar as it does with the SDK methods then all you have to do is switch targets to the "Documentation" target and run it. After it completes optionally restart Xcode and then you should be able to see the comments for each method/property from the quick help tab.

For some reason appledoc failed to cooperate this time and although it manages to add all the comments in Xcode docset so that they can be viewed from the navigation bar; the index.html document it creates that is supposed to display all documentation is blank.

Since I wasted too much time on trying to get appledoc to work I simply used Doxygen which managed to create the documentation html correctly. The shortcut to the documentation html can be found in the root of the project folder.

A small reminder since I tend to forget this myself; since I’m using CocoaPods with the project to run it correctly you need to open the workspace file instead of the project file.
