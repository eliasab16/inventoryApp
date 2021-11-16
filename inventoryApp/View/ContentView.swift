//
//  ContentView.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 7/1/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var model : ViewModel
    
    var body: some View {
        NavigationView {
            if model.signedIn {
                AccessView()
            }
            else {
                LogInView()
            }
        }
        .onAppear {
            model.signedIn = model.isSignedIn
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

// an abstract of the log in view
struct LogInView: View {
    @EnvironmentObject var model: ViewModel
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Form {
                Image("logo-cropped")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                Section {
                    // sign in button
                    Button(action: {
                        model.signIn(email: email, password: password)
                    }) {
                        Spacer()
                        Text("Sign In")
                        Spacer()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color(UIColor.systemBlue))
                    .disabled(email.isEmpty || password.isEmpty)
                }
            }
        }
        // keyboard avoidance - push form up
    }
    
}

// an abstract of access view

struct AccessView: View {
    
    @EnvironmentObject var model : ViewModel
    
    @State var showingScanner = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
//            VStack(alignment: .trailing) {
//                Button(action: {
//                    model.signOut()
//                }, label: {
//                    Text("Sign Out")
//                        .foregroundColor(Color.blue)
//                })
//            }
            VStack{
                Image("logo-cropped")
                    .resizable()
                    .padding([.top, .leading, .trailing])
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                // open scanner button
                VStack (alignment: .trailing){
                    Spacer ()
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        self.showingScanner.toggle()
                    }) {
                        Text("התחל סריקה")
                        Image(systemName: "barcode.viewfinder")
                            .resizable()
                            .frame(width: 45.0, height: 45.0)
                        
                    }.sheet(isPresented: $showingScanner) {
                        ScannerView()
                    }
                    Spacer()
                    // sign out button
                    Button(action: {
                        self.showingScanner.toggle()
                    }) {
                        Text("התנתק")
                        Image(systemName: "arrow.backward.square")
                            .resizable()
                            .frame(width: 45.0, height: 45.0)
                        
                        
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
            }
        }
    }
}


// keyboard avoidance code, source: (https://stackoverflow.com/questions/56491881/move-textfield-up-when-the-keyboard-has-appeared-in-swiftui)

//struct AdaptsToKeyboard: ViewModifier {
//    @State var currentHeight: CGFloat = 0
//
//    func body(content: Content) -> some View {
//        GeometryReader { geometry in
//            content
//                .padding(.bottom, self.currentHeight)
//                .onAppear(perform: {
//                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
//                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
//                        .compactMap { notification in
//                            withAnimation(.easeOut(duration: 0.16)) {
//                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//                            }
//                    }
//                    .map { rect in
//                        rect.height - geometry.safeAreaInsets.bottom
//                    }
//                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
//
//                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
//                        .compactMap { notification in
//                            CGFloat.zero
//                    }
//                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
//                })
//        }
//    }
//}
//
//extension View {
//    func adaptsToKeyboard() -> some View {
//        return modifier(AdaptsToKeyboard())
//    }
//}
