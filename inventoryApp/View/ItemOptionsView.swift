//
//  ItemOptionsView.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-12.
//

import SwiftUI

struct ItemOptionsView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        HStack {
            Text(model.nickname)
        }
        
        // Checkout
        
        // Checkin
    }
}

struct ItemOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemOptionsView()
    }
}
