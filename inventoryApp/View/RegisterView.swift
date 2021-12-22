//
//  RegisterView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-08.
//

import SwiftUI
import UIKit

struct RegisterView: View {
    // passing variable showReg from Scanner View - this variable indicates whether Register View should be displayed
    @EnvironmentObject var model : ViewModel
    
    @Binding var showReg: Bool
    
    // to add another field, declare below, add to the form, and add to ViewModel and ItemOptionsView
    @State var type = ""
    @State var brand = ""
    @State var stock = ""
    @State var recQuantity = ""
    @State var nickname = ""
    @State var supplier = ""
    
    @State var editDisable = true
    
    @State private var selectedSupplier = 1
    var suppliers = ["ABB", "Schneider", "Kahane"]
    
    var body: some View {
        VStack {
//            NavigationView {
                Form {
                    HStack {
                        Text("פריט אינו קיים במלאי")
                    }
                    
                    // section
                    // item details
                    Section(header: Text("הקלד פרטים")) {
                        HStack {
                            Text("חברה")
                            Spacer()
                            TextField("חברה", text: $brand)
                                .fixedSize()
                        }
                        
                        HStack {
                            Text("סוג פריט")
                            Spacer()
                            TextField("סוג פריט", text: $type)
                                .fixedSize()
                        }
                        
                        HStack {
                            Text("כינוי")
                            Spacer()
                            TextField("כינוי", text: $nickname)
                                .fixedSize()
                        }
                        
                        HStack {
                            Picker(selection: $selectedSupplier, label: Text("ספק")) {
                                //                                ForEach(0 ..<suppliers.count) { index in
                                //                                    Text(self.suppliers[index]).tag(index)
                                //                                }
                                Text("ABB").tag(0)
                                Text("Schneider").tag(1)
                                Text("Kahane").tag(2)
                            }
                        }
                        
                        HStack {
                            Text("ספק")
                            Spacer()
                            TextField("ספק", text: $supplier)
                                .fixedSize()
                        }
                        
                        HStack {
                            // !! should create a dropdown menu
                            Text("כמות במלאי")
                            Spacer()
                            TextField("כמות במלאי", text: $stock)
                                .keyboardType(.decimalPad)
                                .fixedSize()
                        }
                        
                        HStack {
                            // !! should create a dropdown menu
                            Text("כמות מומלצת")
                            Spacer()
                            TextField("כמות מומלצת", text: $recQuantity)
                                .keyboardType(.decimalPad)
                                .fixedSize()
                        }
                    }
                    
                    // section
                    // button section
                    Section {
                        Button(action: {
                            
                            // Call add data
                            model.addData(id: model.barcodeValue, brand: brand, type: type, stock: Int(stock) ?? 0, nickname: nickname, supplier: supplier, recQuantity: Int(recQuantity) ?? 0)
                            
                            // Clear the text fields
                            brand = ""
                            type = ""
                            stock = ""
                            nickname = ""
                            supplier = ""
                            recQuantity = ""
                            
                            // close down window - return to Scanner View
                            showReg.toggle()
                            
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("הוסיף")
                                Spacer()
                            }
                        })
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color(UIColor.systemBlue))
                        // if any of the three entries (except nickname) is empty, disable button
                            .disabled(type.isEmpty || brand.isEmpty || stock.isEmpty)
                    }
                }
                .navigationBarTitle("הוספת פריט למלאי")
                // hide the keyboard if user clicks outside the form
                .onTapGesture {
                    hideKeyboard()
                }
                .environment(\.layoutDirection, .rightToLeft)
            }
        }
//    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegisterView(showReg: .constant(true))
                .preferredColorScheme(.light)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
