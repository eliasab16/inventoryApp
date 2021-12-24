//
//  SettingsView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-12-23.
//

import SwiftUI

struct SettingsView: View {
    @State var showingCustomers = false
    @State var showingSuppliers = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SuppliersView(), isActive: $showingSuppliers) { EmptyView() }
                
                //            NavigationLink(destination: CustomersView(), isActive: $showingCustomers) { EmptyView() }
                
                Form {
                    Section {
                        Button {
                            showingSuppliers = true
                        } label: {
                            HStack {
                                Text("ספקים")
                                Spacer()
                                Image(systemName: "lessthan")
                            }
                        }
                    }
                }
                .navigationTitle("הגדרות")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
