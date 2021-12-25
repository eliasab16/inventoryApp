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
    @State var brand = ""
    @State var type = ""
    @State var nickname = ""
    @State var supplier = ""
    @State var recQuantity = ""
    
    @State var editDisabled = true
    @State var showEditBtn = true
    @State var showingDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                // section
                // list all item details
                Section(header: Text("פרטים")) {
                    // dropdown meny for suppliers
                    if editDisabled {
                        HStack {
                            Text("חברה")
                            Spacer()
                            Text(String(model.brand))
                                .foregroundColor(Color(UIColor.systemGray4))
                        }
                    }
                    else {
                        // important: poopulate the brand variable wth model.brand to show on the picker
                        Picker(selection: $brand, label: Text("חברה")) {
                            ForEach(model.brandsList) { brand in
                                Text(brand.name)
                            }
                        }
                    }
                    
                    HStack {
                        Text("סוג")
                        TextField(String(model.type), text: $type)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                            .multilineTextAlignment(TextAlignment.trailing)
                        
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                    }
                    
                    HStack {
                        Text("כינוי")
                        TextField(String(model.nickname), text: $nickname)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                            .multilineTextAlignment(TextAlignment.trailing)

                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                    }
                    
                    // dropdown meny for suppliers
                    if editDisabled {
                        HStack {
                            Text("ספק")
                            Spacer()
                            Text(String(model.supplier))
                                .foregroundColor(Color(UIColor.systemGray4))
                        }
                    }
                    else {
                        Picker(selection: $supplier, label: Text("ספק")) {
                            ForEach(model.suppliersList) { supplier in
                                Text(supplier.name)
                            }
                        }
                    }
                    
                    HStack {
                        Text("כמות במלאי")
                        TextField(String(model.stock), text: $quantity)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                            .multilineTextAlignment(TextAlignment.trailing)
                        
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                    }
                    
                    HStack {
                        Text("כמות מומלצת")
                        TextField(String(model.recQuantity), text: $recQuantity)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(TextAlignment.trailing)
                        
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                    }
                    
                    // edit information and done buttons - alternate between the two button
                    HStack {
                        if editDisabled {
                            Button(action: {
                                // updating supplier and brand for the picker
                                supplier = model.supplier
                                brand = model.brand
                                editDisabled = false
                            }) {
                                Image(systemName: "pencil")
                                Text("ערוך פרטים")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color(UIColor.systemBlue))
                        }
                        else {
                            Button(action: {
                                // showEditBtn = true
                                self.model.updateData(id: model.barcodeValue,
                                                      brand: brand.isEmpty ? model.brand : brand,
                                                      type: type.isEmpty ? model.type : type,
                                                      nickname: nickname.isEmpty ? model.nickname: nickname,
                                                      supplier: supplier.isEmpty ? model.supplier : supplier,
                                                      recQuantity: (recQuantity.isEmpty ? model.recQuantity : Int(recQuantity)) ?? model.recQuantity)
                                editDisabled = true
                            }) {
                                Image(systemName: "checkmark")
                                Text("סיום")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
                
                // section
                // Pick quantity
                Section(header: Text("מספר פריטים לפעולה")) {
                    TextField("כמות", text: $quantity)
                        .keyboardType(.decimalPad)
                }
                
                // section
                // Pick action
                Section(header: Text("פעולה")) {
                    // Button to add into inventory
                    Button(action: {
                        model.updateQuantity(id: model.barcodeValue, quantity: Int(quantity) ?? 0)
                        quantity = ""
                        // return to previous view
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 22.0, height: 22.0)
                            Text("הוסיף למלאי")
                        }
                    }
                    .disabled(quantity.isEmpty)
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color(UIColor.systemBlue))
                    
                    
                    // Button to check out from inventory
                    Button(action: {
                        model.updateQuantity(id: model.barcodeValue, quantity: Int("-" + quantity) ?? 0)
                        // return to previous view
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 22.0, height: 22.0)
                            Text("הוציא מהמלאי")
                        }
                    }
                    .disabled(quantity.isEmpty)
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color(UIColor.systemBlue))
                }
                
                // section
                // delete item from inventorye
                Section {
                    HStack {
                        Button(action: {
                            // self.showingOutInv.toggle()
                            showingDeleteAlert = true
                        }) {
                            HStack {
                                Spacer()
                                Text("מחק")
                                Spacer()
                            }
                            //                            .foregroundColor(Color(UIColor.systemBlue))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color(UIColor.systemRed))
                    }
                }
            }
            // hide the keyboard if user clicks outside the form
//            .onTapGesture {
//                hideKeyboard()
//            }
            .ignoresSafeArea()
            .navigationBarTitle("פרטים")
            .alert(isPresented: $showingDeleteAlert) {
                        Alert(
                            title: Text("בטוח למחוק?"),
                            message: Text("לא ניתן לשחזר אחרי מחיקה"),
                            primaryButton: .destructive(Text("מחק")) {
                                // delete
                                model.deleteData(id: model.barcodeValue)
                                // return to previous view
                                showOptions.toggle()
                            },
                            secondaryButton: .cancel(Text("ביטול"))
                        )
                    }
            
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct ItemOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemOptionsView(showOptions: .constant(true))
    }
}

