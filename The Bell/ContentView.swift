//
//  ContentView.swift
//  The Bell
//
//  Created by Collin on 12/1/22.
//
//  || PLEASE NOTE ---------------------------------------------
//  || This is formatted for the iPhone 8 ONLY (due to time constraints).
//  || All other devices will have distorted views.
//  || For Custom format: change .frame, .offset, and .font
//  || - Collin
//  ||----------------------------------------------------------
//


import SwiftUI
import WebKit
import FirebaseDatabase
import Foundation

//The home page view
struct ContentView: View {
  
  //Reference to ReadViewModel.swift
  @StateObject var viewModel = ReadViewModel()

  //Default URL if cannot retrieve from firebase database
  @State private var showWebView = false
  private let urlString: String = "https://www.picsum.photos"
  
    
  //sets the camera display name
  var camViewName = "Front Door Cam"
  
  var body: some View {
    
    //NavigationView allows use to switch to other struct views (photoView etc)
    NavigationView{
      
      //Zstack is used to format things in layers, each object will layer on top of the previous
      ZStack(){
        
        //Sets the background color and ignores format safe zones
        Color(.sRGB, red: 0.674, green: 0.946, blue: 0.953)
          .ignoresSafeArea()
        
        
        //checks if a string was grabbed from the firebase database
        if viewModel.value != nil {
          
          //loads the webview with database weblink and formats its position, size, and shadow
          WebView(url: URL(string: viewModel.value!)!).frame(width: 300, height: 260.0).cornerRadius(20).shadow(color: .black.opacity(0.35),radius: 6.0, x: 0, y: 5)
          
        }
        else {
          
          //loads the webview using default link and formats its position, size, and shadow
          WebView(url: URL(string: urlString)!).frame(width: 300, height: 260.0).cornerRadius(20).shadow(color: .black.opacity(0.35),radius: 6.0, x: 0, y: 5)
          
        }
      
        
        //loads background image for buttons to sit on and repositions it
        Image("IMG_0908").renderingMode(.original).resizable(resizingMode: .stretch).frame(width: 385, height: 395).offset(x: 0, y: 130)
        
        //loads the camera name with customizable system image
        Label(camViewName, systemImage: "video")
          .foregroundColor(.black)
          .padding(.horizontal)
          /* Adds low opacity white background with rounded corners (a bubble) around the label
          .background(Color(hue: 0.6, saturation: 0.505, brightness: 1.80))
          .foregroundColor(.white)
          .cornerRadius(20)*/
          .offset(y: 160)
          .font(.title3)
          .bold()
        
        //formats "The Bell" title at the top of the phone
        Label("The Bell", systemImage: "lock.icloud.fill")
          .foregroundColor(.white)
          .padding(.all)
          .background(Color(hue: 1.0, saturation: 0.005, brightness: 0.3))
          .foregroundColor(.white)
          .cornerRadius(20)
          .offset(y: -285)
          .font(.title)
          .bold()
        
        //formats the "Your Camera" text
        Text("Your Camera")
          .foregroundColor(.black)
          .padding(.horizontal)
          /* Adds white background with rounded corners (a bubble) around the text
          .background(Color(hue: 0.5, saturation: 0.005, brightness: 1.0))
          .foregroundColor(.white)
          .cornerRadius(20)*/
          .offset(x: -50, y: -160)
          .font(.title)
          .bold()
        
        //Decorative home button that just prints to console when pressed
        Button {
          print("Pressed Home")
        }
          label: {Image (systemName: "house.fill")}
            .offset(y: 290)
            .font(.largeTitle)
            .bold()
            .tint(.white)
        
        //Clips/recordings button that links to the clipsView
        NavigationLink(destination: clipsView()) {
          Label("", systemImage: "film.stack")
            .font(.largeTitle)
            .bold()
            .tint(.white)
        }.offset(x: 140, y: 285)
        
        //Photos button that links to the photoView
        NavigationLink(destination: photoView()) {
          Label("", systemImage: "photo.on.rectangle")
            .font(.largeTitle)
            .bold()
            .tint(.white)
        }.offset(x: -140, y: 285)
        
      }
      
      //runs the readValue function on view launch to retrieve firebase data
    }.onAppear(perform: viewModel.readValue)
    
  }

  
}

//Used for viewing photos from firebase
struct photoView: View {
  
  //Reference to ReadViewModel.swift
  @StateObject var viewModel = ReadViewModel()
  
  var body: some View{
    
    VStack{
      
      if viewModel.object != nil {
        VStack{
          
          Text(viewModel.object!.date_created)
            .padding()
          
          Text(viewModel.object!.date_created_formatted)
            .padding()
          
          if viewModel.object!.is_photo{
            Text("true")
              .padding()
          }
          else{
            Text("false")
              .padding()
          }
          
          Text(viewModel.object!.path)
            .padding()
          
        }
        
        
      }
      else {
        Text("EMPTY PHOTOS")
        
      }
    }.onAppear(perform: viewModel.readObject)
    
  }
}

//Used for viewing clips from firebase
struct clipsView: View {
  
  //Test comment for github
  
  //Reference to ReadViewModel.swift
  @StateObject var viewModel = ReadViewModel()
  
  var body: some View{
    
    VStack{
      
      if viewModel.object != nil {
        VStack{
          
          Text(viewModel.object!.date_created)
            .padding()
          
          Text(viewModel.object!.date_created_formatted)
            .padding()
          
          if viewModel.object!.is_photo{
            Text("true")
              .padding()
          }
          else{
            Text("false")
              .padding()
          }
          
          Text(viewModel.object!.path)
            .padding()
          
        }
        
        
      }
      else {
        Text("EMPTY CLIPS")
        
      }
    }.onAppear(perform: viewModel.readObject)
    
  }
}

//structures the webview and updates the UI view
struct WebView: UIViewRepresentable{
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

//Used to preview app in real time within Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
