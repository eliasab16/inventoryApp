//
//  SuppliersView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-12-23.
//

import SwiftUI

struct SuppliersView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("בחר ספק")) {
                    List(model.suppliersList) { supplier in
                        HStack {
                            Text(supplier.name)
                        }
                    }
                }
            }
            .navigationBarTitle("ספקים")
        }
    }
}

struct SuppliersView_Previews: PreviewProvider {
    static var previews: some View {
        SuppliersView()
    }
}
