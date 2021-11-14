//
//  ContentView.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 7/1/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingScanner = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack{
                Image("logo-cropped")
                    .resizable()
                    .padding([.top, .leading, .trailing])
                    .aspectRatio(contentMode: .fit)
                    
                Spacer()
                
                Button(action: {
                    self.showingScanner.toggle()
                }) {
                    Image(systemName: "barcode.viewfinder")
                        .resizable()
                        .frame(width: 45.0, height: 45.0)
                    
                    Text("Open Scanner")
                }.sheet(isPresented: $showingScanner) {
                    ScannerView()
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// hide keyboard if user clicks outside form
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
