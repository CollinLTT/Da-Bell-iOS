# Da Bell iOS Application
A group project made for the class CS-578 at San Diego State University in the Fall of 2022.
This app was formatted for the iPhone 8 running on iOS 16.1

Da Bell is a custom Ring Doorbell alternative that is low in cost and provides similar functionality without audio or speaking capability. It runs using a Raspberry Pi, camera, button (doorbell), and iOS app.

### Table of Contents
- [Main Project Page](#project-home)
- [Capabilities](#capabilities)
- [Video Demo](#video-demo)
- [Installation](#installation)
- [Improvements](#improvements)

## Main Project Page:

To view the main page for the project which includes all the project's components follow this link: [Main Project Page](https://github.com/Amark18/Da-Bell).

## Capabilities:

The iOS app pulls from FireBase storage and formats the data to be viewed on an app made for the iPhone 8. All of the data displayed on the app comes from the Firebase cloud meaning no data is stored on the app and as such the app runs quickly and has low storage costs. A live camera feed is displayed in a webView on the app's home screen using a link from the Firebase storage. The app also has two buttons on the home screen which take you to see the photos from the Firebase storage or the 3-second videos. The "photos" button presents you with a vertical scroll-view of photos in a 3-column format and the list is populated with photos moving to the right. The "videos" button presents you with a vertical scroll-view list with the date the videos recorded and each item in the list is pressable. The list of videos is populated with the newest video appearing at the top of the list. Once a video date is pressed from the list, it opens the video player view which would allow the user to watch the 3-second video.

## Video Demo:

A video demonstrating the app's function and format can be seen here: [iOS App Demo](https://youtube.com/shorts/165S-_A97tA?feature=share). It first shows the live stream by clicking the play button on the home screen, then the photos from the Firebase cloud, and finally the list of clips from the cloud which once selected takes you to a video player.

## Installation:

#### Device Requirements:
- Must have an Apple Computer or device with the ability to run XCode.
- The Da Bell app only works on iOS 16.1 and would need to be updated to run on newer versions, but this is a simple fix in XCode.

##### 1. Getting started with XCode
```shell
1. Using your device install and run XCode.
2. In XCode open an existing project and select the "The Bell" file.
3. Here you can make changes to the code.
```

##### 2. Editing the Code
- To change how the app looks you will edit the code from ContentView.swift.
- The app is formatted using a Zstack view and as such objects will have different layers be aware when changing or adding new objects.
- To change how the app takes in the data from the Firebase storage you will need to edit StorageManager.swift and ContentView.swift.


##### 3. Updating the iOS and Device Simulator
# To change the device and iOS version follow these steps:
- File > Open Simulator > iOS [current version] > Select Device


##### 4. Running the App on Your Desired Device.
- To run the app on an iOS device follow these steps:
```shell
# Under the app's general settings on XCode make sure the "Signing" portion is filled out and has a working certificate.
# Connect your desired device to your computer running XCode via a USB or other cable.
# In XCode hit the Window button at the top, then select Devices and Simulators.
# You should be prompted on your device to trust the computer, hit trust.
# After it processes for a bit, go to where you select the device to simulate.
# Select the device you have connected to the computer.
# Run the program and it should automatically install the app to the device.
```

## Improvements:

Due to time constraints the app was only formatted for the iPhone 8 and had some functions of the app hard coded to display the functionality of the Firebase storage. I had to learn to use Swift, XCode, Firebase, and a Mac computer in the time span of a few weeks and as such there are many ways in which the app can be improved. 

Ideas for Improvement:
 - Update the live stream webView to be automatic (Apple had a bug in which automatically opening non https links caused compilation errors).
 - Improve the design of the app.
 - Allow formatting to be automatic for all devices.
 - Remove and update any hard coded elements.
 - Make the videos in the list of videos playable and not link to a separate video player view.
 - Allow the photos to be maximized when pressed for a full and better view.
 - Change the name of the app from "The Bell" to "Da Bell" (Project name was changed half way in).
