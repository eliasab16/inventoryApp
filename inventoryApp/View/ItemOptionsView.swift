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
                Section(header: Text("פרטים"), footer: Text("* זו לא הכמות הנוכחית במאלי")) {
                    HStack {
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                        TextField(String(model.brand), text: $brand)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                        Spacer()
                        Text("חברה")
                    }
                    
                    HStack {
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                        TextField(String(model.type), text: $type)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                        Spacer()
                        Text("סוג")
                    }
                    
                    HStack {
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                        TextField(String(model.nickname), text: $nickname)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                        Spacer()
                        Text("כינוי")
                    }
                    
                    HStack {
                        if !editDisabled {
                            Image(systemName: "arrow.right")
                        }
                        TextField(String(model.supplier), text: $supplier)
                            .foregroundColor(Color.gray)
                            .disabled(editDisabled)
                        Spacer()
                        Text("ספק")
                    }
                    
                    HStack {
                        if editDisabled {
                            Text(String(model.stock))
                                .foregroundColor(Color.gray)
                            Text("/ " + String(model.recQuantity))
                            Spacer()
                            Text("כמות במלאי")
                        }
                        // edit recommended quantity
                        else {
                            Image(systemName: "arrow.right")
                            TextField(String(model.recQuantity), text: $recQuantity)
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text("כמות מומלצת במלאי*")
                        }
                    }
                    
                    // edit information and done buttons - alternate between the two button
                    HStack {
                        if editDisabled {
                            Button(action: {
//                                showEditBtn = false
                                editDisabled = false
                            }) {
                                Spacer()
                                Text("ערוך פרטים")
                                Image(systemName: "pencil")
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
                                Spacer()
                                Text("סיום")
                                Image(systemName: "checkmark")
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
                        // reset value
                        quantity = ""
                        // return to previous view
                        showOptions.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Text("הוסיף למלאי")
                            Image(systemName: "tray.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 22.0, height: 22.0)
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
                            Spacer()
                            Text("הוציא מהמלאי")
                            Image(systemName: "tray.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 22.0, height: 22.0)
                        }
                        //                            .foregroundColor(Color(UIColor.systemBlue))
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
            .onTapGesture {
                hideKeyboard()
            }
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
        Spacer()
    }
}

struct ItemOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemOptionsView(showOptions: .constant(true))
    }
}

