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
    
    var body: some View {
            VStack {
                Form {
                    HStack {
                        Spacer()
                        Text("פריט אינו קיים במלאי")
                    }
                    Section(header: Text("הקלד פרטים")) {
                        HStack {
                            TextField("חברה", text: $brand)
                                .disabled(editDisable)
                            Spacer()
                            Text("חברה")
                        }
                        TextField("סוג פריט", text: $type)
                        TextField("כינוי", text: $nickname)
                        // !! should create a dropdown menu
                        TextField("ספק", text: $supplier)
                        TextField("כמות", text: $stock)
                            .keyboardType(.decimalPad)
                        TextField("כמות מומלצת", text: $recQuantity)
                            .keyboardType(.decimalPad)
                    }
                    // button section
                    Section {
                        Button  {
                            editDisable.toggle()
                        } label: {
                            Text("edit")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color(UIColor.systemBlue))

                        
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
                        //                            .padding(.horizontal, 70.0)
                        //                            .padding(.vertical, 30.0)
                        //                            .buttonStyle(RoundedRectangleButtonStyle())
                        //                            .buttonStyle(BorderlessButtonStyle())
                        //                            .buttonStyle(DefaultButtonStyle())
                        // if any of the three entries (except nickname) is empty, disable button
                            .disabled(type.isEmpty || brand.isEmpty || stock.isEmpty)
                    }
                }
                .navigationBarTitle("הוספת פריט למלאי")
                // hide the keyboard if user clicks outside the form
                .onTapGesture {
                    hideKeyboard()
                }
            }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showReg: .constant(true))
            .preferredColorScheme(.light)
    }
}
