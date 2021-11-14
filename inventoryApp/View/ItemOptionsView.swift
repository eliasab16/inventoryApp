//
//  ItemOptionsView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-12.
//

import SwiftUI

struct ItemOptionsView: View {
    @EnvironmentObject var model: ViewModel
    
    @State var quantity = ""
    
    @State var showingAddInv = false
    @State var showingOutInv = false
    
    var body: some View {
        VStack(alignment: .leading) {
                Form {
                    // Pick quantity
                    Section(header: Text("NUMBER OF ITEMS")) {
                        TextField("Quantity", text: $quantity)
                            .keyboardType(.decimalPad)
                    }
                    
                    // Pick action
                    Section(header: Text("ACTION TO PERFORM")) {
                    // Button to add into inventory
                        Button(action: {
//                            self.showingAddInv.toggle()
                            model.updateQuantity(id: model.barcodeValue, quantity: Int(quantity) ?? 0)
                            
                        }) {
                            HStack {
                                Image(systemName: "tray.and.arrow.down.fill")
                                    .resizable()
                                    .frame(width: 22.0, height: 22.0)
                                
                                Text("Check into inventory")
                            }
                        }
                        .disabled(quantity.isEmpty)
                        
                        
                        // Button to check out from inventory
                        Button(action: {
//                            self.showingOutInv.toggle()
                            model.updateQuantity(id: model.barcodeValue, quantity: Int("-" + quantity) ?? 0)
                        }) {
                            HStack {
                                Image(systemName: "tray.and.arrow.up.fill")
                                    .resizable()
                                    .frame(width: 22.0, height: 22.0)
                                
                                Text("Check out of inventory")
                            }
                        }
                        .disabled(quantity.isEmpty)
//                        .sheet(isPresented: $showingOutInv) {
//                            ScannerView()
//                        }
                    }
                }
                // hide the keyboard if user clicks outside the form
                .onTapGesture {
                    hideKeyboard()
                }
                .ignoresSafeArea()
        }
        Spacer()
    }
}

struct ItemOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemOptionsView()
    }
}

