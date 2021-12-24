//
//  Inventory.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-07.
//

import Foundation

struct Inv: Identifiable {
    var id: String
    
    var brand: String
    var type: String
    var stock: Int
    var nickname : String
    var supplier : String
    var recQuantity: Int
}

struct Iden: Identifiable {
    var id: String
    
    var name: String
}
