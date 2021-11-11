//
//  RegisterView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-08.
//

import SwiftUI

struct RegisterView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .lightGray // Uses UIColor
        }
    
    @State var name = ""
    @State var type = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add details")) {
                    TextField("name", text: $name)
                    //                        .foregroundColor(Color.blue)
                    //                        .background(Color.white)
                    TextField("type", text: $type)
                }
            }
            .listRowBackground(Color.white)
            .navigationBarTitle("Register").foregroundColor(.black)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
