//
//  ContentView.swift
//  intag
//
//  Created by Z Salti on 11/12/22.
//

import SwiftUI

struct ContentView: View {
    
    
//    @State var theText: String = ""
    let iqama = IqamaTimes()
    
    var body: some View {
        /*
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
         */
        
        /*
        var yo: Text = Text("Wassup")
        var bruh: some View = yo.padding()
        return bruh
         */
        
//        Button("Click me", action: brodie)
//        Button("Click me", action: <#T##() -> Void#>) // It wants a function type that takes no paramters and returns void
//        Button("Click me", action: {
//            print("hello")
//        })
        
        
        
        VStack {
            // Button instance with closure
            Button("Click me", action: {
                print("hello")
            })
            
            // Button instance with trailing closure
            Button("Clock me") {
                
                
                
            }
            
            
            // Button instance with label view
            Button(action: {
                print("Youpe")
            }, label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            })
            
//            Text(theText)
            
            
            let fajr = iqama.times[0]
            let duhr = iqama.times[1]
            let asr = iqama.times[2]
            let maghrib = iqama.times[3]
            let isha = iqama.times[4]
            
            Text(String(fajr.hour!) + ":" + String(fajr.minute!))
            Text(String(duhr.hour!) + ":" + String(duhr.minute!))
            Text(String(asr.hour!) + ":" + String(asr.minute!))
            Text(String(maghrib.hour!) + ":" + String(maghrib.minute!))
            Text(String(isha.hour!) + ":" + String(isha.minute!))
            
        }
        
    }
}

func brodie() -> Void {
    
    print("Hello")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
