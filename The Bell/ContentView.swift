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
import FirebaseStorage
import Foundation
import PhotosUI
import SafariServices
import SDWebImageSwiftUI

//Default url for new webview
var safariLink = "https://www.picsum.photos"

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
        Color(.white)
          .ignoresSafeArea()
        
        //Webview background lookalike
        Image(systemName: "")
          .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 0.9))
          .font(.largeTitle)
          .frame(width: 300, height: 270)
          //.background(Color(hue: 0.0, saturation: 0.0, brightness: 0.9))
          .background(Gradient(colors: [.blue,.orange]))
          .cornerRadius(15)
          .shadow(color: .black.opacity(0.25),radius: 2.0, x: 0, y: 6)
          .offset(x: 0, y: 0)
        
        //loads background image for buttons to sit on and repositions it
        Image("IMG_0910").renderingMode(.original).resizable(resizingMode: .stretch).frame(width: 385, height: 395).offset(x: 0, y: -460)
        
        //loads background image for buttons to sit on and repositions it
        Image("IMG_0908").renderingMode(.original).resizable(resizingMode: .stretch).frame(width: 385, height: 395).offset(x: 0, y: 130)
        
        //loads the camera name with customizable system image
        Label(camViewName, systemImage: "video")
          .foregroundColor(.black)
          .padding(.horizontal)
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
          .offset(x: -50, y: -160)
          .font(.largeTitle)
          .bold()
        
        
        //Group of navigation buttons
        Group {
          
          //checks if a string was grabbed from the firebase database
          if viewModel.value != nil {
            
            //loads the webview with database weblink and formats its position, size, and shadow
            /*WebView(url: URL(string: viewModel.value!)!).frame(width: 300, height: 260.0).cornerRadius(20).shadow(color: .black.opacity(0.25),radius: 4.0, x: 0, y: 8)*/
            
            /*NavigationLink(destination: safariView()) {
              Button{ viewModel.readValue()} label: {Image (systemName: "play.circle")}
                .font(.largeTitle)
                .tint(.white)
            }*/
            
            NavigationLink(destination: safariView()) {
              Image(systemName: "play.circle")
                .font(.largeTitle)
                .tint(.white)
              
            }

          }
          else {
            
            //loads the webview using default link and formats its position, size, and shadow
            /*WebView(url: URL(string: urlString)!).frame(width: 300, height: 260.0).cornerRadius(20).shadow(color: .black.opacity(0.35),radius: 6.0, x: 0, y: 5)*/
            
            NavigationLink(destination: safariView()) {
              Label("", systemImage: "play.circle")
                .font(.largeTitle)
                .tint(.gray)
              
            }
            
          }
          
          //Decorative home button that just prints to console when pressed
          Button {
            //Refreshes the link from Firebase
            viewModel.readValue()
            safariLink = viewModel.value!
            print("Pressed Home")
            
            viewModel.readAllPhotos()
            for lulu in viewModel.sillyString {
              print(lulu)
            }
            
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
        
      }
      
      //runs the readValue function on view launch to retrieve firebase data
    }.onAppear(perform: viewModel.observeDataChange)
      .navigationBarTitle("Home")
    
  }

  
}

//Loads live link from database in new safariView
struct safariView: UIViewControllerRepresentable {

  func makeUIViewController(context: UIViewControllerRepresentableContext<safariView>) -> SFSafariViewController {

    let controller = SFSafariViewController(url: URL(string: safariLink)!)
    
      return controller

  }
  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<safariView>) {
    
  }
  
}

//loads image from firebase storage
struct Loader: UIViewRepresentable{
  
  func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.startAnimating()
    return indicator
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
  }
  
}

//Used for viewing photos from firebase
struct photoView: View {
  
  @State var url1 = ""
  @State var url2 = ""
  @State var url3 = ""
  @State var url4 = ""
  @State var url5 = ""
  @State var url6 = ""
  @State var url7 = ""
  
  @State var url8 = ""
  @State var url9 = ""
  @State var url10 = ""
  @State var url11 = ""
  @State var url12 = ""
  @State var url13 = ""
  
  //Adjusts the presentation mode for custom navigation button
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  //View to display customizable back button
      var btnBack : some View { Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          }) {
              HStack {
                //back arrow
                Image(systemName: "arrowshape.left.fill") // set image here
                  .aspectRatio(contentMode: .fit)
                  .foregroundColor(.black)
                
                //text next to back arrow
                  Text("Home")
                  .foregroundColor(.cyan)
                  .font(.title2)
                
                
              }
          }
      }
  
  
  var body: some View{
    
    VStack (alignment: .leading){
      
      //formats the "Photos" text
      Text("Photos")
        .foregroundColor(.black)
        .padding(.horizontal)
        .font(.largeTitle)
        .bold()
      
      GeometryReader { geo in
        ScrollView{
          LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
          ], spacing: 15){

            Group{
              if url1 != "" {
                
                AnimatedImage(url: URL(string: url1)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
              
              if url2 != "" {
                
                AnimatedImage(url: URL(string: url2)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
              
              if url3 != "" {
                
                AnimatedImage(url: URL(string: url3)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
              
              if url4 != "" {
                
                AnimatedImage(url: URL(string: url4)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
              
              if url5 != "" {
                
                AnimatedImage(url: URL(string: url5)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
              
              if url6 != "" {
                
                AnimatedImage(url: URL(string: url6)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
              
              if url7 != "" {
                
                AnimatedImage(url: URL(string: url7)!)
                  .frame(width: 110, height: 110)
                  .cornerRadius(15)
                  .padding()
                
              }
              else{
                Loader()
              }
            }
            
            if url8 != "" {
              
              AnimatedImage(url: URL(string: url8)!)
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding()
                
            }
            else{
              Loader()
            }
            
            if url9 != "" {
              
              AnimatedImage(url: URL(string: url9)!)
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding()
                
            }
            else{
              Loader()
            }
            
            if url10 != "" {
              
              AnimatedImage(url: URL(string: url10)!)
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding()
                
            }
            else{
              Loader()
            }
            
            if url11 != "" {
              
              AnimatedImage(url: URL(string: url11)!)
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding()
                
            }
            else{
              Loader()
            }
            
            if url12 != "" {
              
              AnimatedImage(url: URL(string: url12)!)
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding()
                
            }
            else{
              Loader()
            }
            
            if url13 != "" {
              
              AnimatedImage(url: URL(string: url13)!)
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding()
                
            }
            else{
              Loader()
            }
              
            
          }
        }
      }.onAppear{
        let storage = Storage.storage().reference()
        storage.child("photos/11_21_2022_01_56_23_AM.jpg").downloadURL{ (url1, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          
          self.url1 = "\(url1!)"
        }
        
        storage.child("photos/11_21_2022_01_57_02_AM.jpg").downloadURL{ (url2, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url2 = "\(url2!)"
        }
        
        storage.child("photos/11_21_2022_02_11_25_AM.jpg").downloadURL{ (url3, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url3 = "\(url3!)"
        }
        
        storage.child("photos/11_21_2022_02_13_23_AM.jpg").downloadURL{ (url4, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url4 = "\(url4!)"
        }
        
        storage.child("photos/11_21_2022_02_16_46_AM.jpg").downloadURL{ (url5, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url5 = "\(url5!)"
        }
        
        storage.child("photos/11_21_2022_02_18_18_AM.jpg").downloadURL{ (url6, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url6 = "\(url6!)"
        }
        
        storage.child("photos/11_21_2022_02_19_29_AM.jpg").downloadURL{ (url7, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url7 = "\(url7!)"
        }
        
        
        storage.child("photos/12_07_2022_12_09_57_AM.jpg").downloadURL{ (url8, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url8 = "\(url8!)"
        }
        
        
        storage.child("photos/12_07_2022_12_13_05_AM.jpg").downloadURL{ (url9, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url9 = "\(url9!)"
        }
        
        
        storage.child("photos/12_07_2022_12_16_09_AM.jpg").downloadURL{ (url10, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url10 = "\(url10!)"
        }
        
        
        storage.child("photos/12_07_2022_12_18_55_AM.jpg").downloadURL{ (url11, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url7 = "\(url11!)"
        }
        
        
        storage.child("photos/12_07_2022_12_22_53_AM.jpg").downloadURL{ (url12, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url12 = "\(url12!)"
        }
        
        
        storage.child("photos/12_07_2022_12_24_17_AM.jpg").downloadURL{ (url13, err) in
          
          if err != nil {
            print ((err?.localizedDescription)!)
            return
          }
          self.url13 = "\(url13!)"
        }
        
      }
      
    }
    //hides the system default back button replaces with custom btnBack
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: btnBack)
    
  }
}

//Used for viewing clips from firebase
struct clipsView: View {
  
  //Reference to ReadViewModel.swift
  @StateObject var viewModel = ReadViewModel()
  
  let posts = ["Dec 06, 2022 | 02:34 PM", "Dec 06, 2022 | 05:16 PM",
               "Dec 06, 2022 | 05:27 PM", "Dec 07, 2022 | 12:08 PM",
               "Dec 07, 2022 | 12:45 PM", "Dec 07, 2022 | 03:31 PM",
               "Dec 07, 2022 | 04:02 PM", "Dec 08, 2022 | 04:23 PM",
               "Dec 08, 2022 | 04:38 PM"]
  
  //Adjusts the presentation mode for custom navigation button
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  //View to display customizable back button
      var btnBack : some View { Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          }) {
              HStack {
                //back arrow
                Image(systemName: "arrowshape.left.fill") // set image here
                  .aspectRatio(contentMode: .fit)
                  .foregroundColor(.black)
                
                //text next to back arrow
                  Text("Home")
                  .foregroundColor(.cyan)
                  .font(.title2)
                
                
              }
          }
      }
  
  var body: some View{
      
    VStack(alignment: .leading){
      
      //formats the "ShortClips" text
      Text("Short Clips")
        .foregroundColor(.black)
        .padding(.horizontal)
        .font(.largeTitle)
        .bold()
      
      GeometryReader { geo in
        ScrollView{
          LazyVGrid(columns: [
            GridItem(.flexible()),
          ], spacing: 20){
            ForEach(posts, id: \.self){ post in
              
              NavigationLink(destination: videoPlayer()) {
                  Text(post)
              }
                .font(.title2)
                .foregroundColor(Color.black)
                .frame(width: geo.size.width/1, height: geo.size.width/5)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.941))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.15),radius: 3.0, x: 0, y: 5)
                
            }
          }
        }
      }
        
    }
    //hides the system default back button replaces with custom btnBack
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: btnBack)
  }
  
}

struct videoPlayer: View{
  
  //Reference to ReadViewModel.swift
  @StateObject var viewModel = ReadViewModel()
  
  //Adjusts the presentation mode for custom navigation button
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  //View to display customizable back button
      var btnBack : some View { Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          }) {
              HStack {
                //back arrow
                Image(systemName: "arrowshape.left.fill") // set image here
                  .aspectRatio(contentMode: .fit)
                  .foregroundColor(.black)
                
                //text next to back arrow
                  Text("Short Clips")
                  .foregroundColor(.cyan)
                  .font(.title2)
                
                
              }
          }
      }
  
  var body: some View{
      
    VStack(alignment: .leading){
      
      //formats the "ShortClips" text
      Text("Video Player")
        .foregroundColor(.black)
        .font(.largeTitle)
        .bold()
        .offset(x: -20, y: -80)
      
      Text("Date:")
        .foregroundColor(.black)
        .padding(.horizontal)
        .font(.title)
        .bold()
        .offset(x: -10, y: -40)
      
      Image(systemName: "video.fill")
        .frame(width: 300, height: 300)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.941))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.15),radius: 2.0, x: 0, y: 6)
        .offset(x: 0, y: -40)
      
      Button("Play Video") {
        print("pressed play")
        //viewModel.readAllPhotos()
        //print(viewModel.sillyString)
    
      }
      .foregroundColor(.black)
        .padding(.horizontal)
        .font(.title)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.98))
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.2),radius: 2.0, x: 0, y: 4)
        .offset(x: 70, y: 0)
        
      
        
    }
    //hides the system default back button replaces with custom btnBack
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: btnBack)
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
