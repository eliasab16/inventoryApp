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
    @Binding var showReg: Bool
    
    @EnvironmentObject var model : ViewModel
    
    @State var type = ""
    @State var brand = ""
    @State var stock = ""
    @State var nickname = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add details")) {
                        TextField("Brand", text: $brand)
                        TextField("Type", text: $type)
                        TextField("Nickname", text: $nickname)
                        TextField("Quantity", text: $stock)
                            .keyboardType(.decimalPad)
                    }
                }
                .navigationBarTitle("Register")
                .onTapGesture {
                    hideKeyboard()
                }
                
                Button(action: {
                    
                    // Call add data
                    model.addData(id: model.barcodeValue, brand: brand, type: type, stock: Int(stock) ?? 0, nickname: nickname)
                    
                    // Clear the text fields
                    brand = ""
                    type = ""
                    stock = ""
                    nickname = ""
                    
                    // close down window - return to Scanner View
                    showReg.toggle()
                    
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Register")
                        Spacer()
                    }
                })
                    .padding(.horizontal, 70.0)
                    .padding(.vertical, 30.0)
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .buttonStyle(BorderlessButtonStyle())
                    .buttonStyle(DefaultButtonStyle())
                    // if any of the three entries (except nickname) is empty, disable button
                    .disabled(type.isEmpty || brand.isEmpty || stock.isEmpty)
                
            }
            .background(Color(UIColor.systemGray6))
            .ignoresSafeArea()
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showReg: .constant(true))
            .preferredColorScheme(.light)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
