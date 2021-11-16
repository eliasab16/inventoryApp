//
//  ItemOptionsView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-12.
//

import SwiftUI

struct ItemOptionsView: View {
    @EnvironmentObject var model: ViewModel
    
    // Binding variable for showing this view
    @Binding var showOptions: Bool
    
    @State var quantity = ""
    
    @State var showingAddInv = false
    @State var showingOutInv = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("QUANTITY IN STOCK")) {
                    Text(String(model.stock))
                }
                // Pick quantity
                Section(header: Text("NUMBER OF ITEMS")) {
                    TextField("Quantity", text: $quantity)
                        .keyboardType(.decimalPad)
                }
                
                // Pick action
                Section(header: Text("ACTION TO PERFORM")) {
                    // Button to add into inventory
                    Button(action: {
                        model.updateQuantity(id: model.barcodeValue, quantity: Int(quantity) ?? 0)
                        // reset value
                        quantity = ""
                        // return to previous view
                        showOptions.toggle()
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 22.0, height: 22.0)
                            
                            Text("Check into inventory")
                        }
                        //                            .foregroundColor(Color(UIColor.systemPurple))
                    }
                    .disabled(quantity.isEmpty)
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color(UIColor.systemBlue))
                    
                    
                    // Button to check out from inventory
                    Button(action: {
                        //                            self.showingOutInv.toggle()
                        model.updateQuantity(id: model.barcodeValue, quantity: Int("-" + quantity) ?? 0)
                        // return to previous view
                        showOptions.toggle()
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 22.0, height: 22.0)
                            
                            Text("Check out of inventory")
                        }
                        //                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                    .disabled(quantity.isEmpty)
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color(UIColor.systemBlue))
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
        ItemOptionsView(showOptions: .constant(true))
    }
}

