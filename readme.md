#Readme

If you want to have Xcode display all my documentation in its right helpbar as it does with the SDK methods then all you have to do is switch targets to the "Documentation" target and run it. After it completes optionally restart Xcode and then you should be able to see the comments for each method/property from the quick help tab.

For some reason appledoc failed to cooperate this time and although it manages to add all the comments in Xcode docset so that they can be viewed from the navigation bar; the index.html document it creates that is supposed to display all documentation is blank.

Since I wasted too much time on trying to get appledoc to work I simply used Doxygen which managed to create the documentation html correctly. The shortcut to the documentation html can be found in the root of the project folder.