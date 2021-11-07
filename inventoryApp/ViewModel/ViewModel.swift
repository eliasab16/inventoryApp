//
//  ViewModel.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-07.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Inv]()
    // save the fetched item in the struct instance below
    @Published var foundItem = Inv(id: "", brand: "", type: "", stock: 0, nickname: "")
    @Published var wasFound = false
    
    // fetch all data function
    
    func getData() {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the docu,emt at a specific path
        db.collection("Inventory").getDocuments { snapshot, error in
            // check for errors
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        // Get all the documents and create Inv structs
                        self.list = snapshot.documents.map { doc in
                            // return an Inv struct. The attributes of the documents are accessed as key,items in a dictionary
                            return Inv(id: doc.documentID,
                                       brand: doc["brand"] as? String ?? "",
                                       type: doc["type"] as? String ?? "",
                                       stock: doc["stock"] as? Int ?? 0,
                                       nickname: doc["nickname"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // handle error
            }
        }
    }
    
    // check if a document exists
    
    func fetchItem(barcode: String) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Reference the document
        let docRef = db.collection("Inventory").document(barcode)
        
        docRef.getDocument { (doc, error) in
            DispatchQueue.main.async {
            
                if let doc = doc, doc.exists {
                    // Document exists
                    // Get relevant data
                    self.foundItem = Inv(id: barcode,
                                     brand: doc["brand"] as? String ?? "",
                                     type: doc["type"] as? String ?? "",
                                     stock: doc["stock"] as? Int ?? 0,
                                     nickname: doc["nickname"] as? String ?? "")
                    
                    self.wasFound = true
                } else {
                    // Document doesn't
                    self.wasFound = false
                }
            }
        }
        
        
    }
    
//    func updateData(toUpdate: Inv) {
//
//        // Get a reference to the database
//        let db = Firestore.firestore()
//
//        let status = toUpdate.completed ? false : true
//
//        // Set the data to update
//        db.collection("tasks").document(toUpdate.id).setData(["completed": status], merge: true)
//
//        // Get data to update the UI
//        self.getData()
//    }
    
    func addData(brand: String, type: String, stock: Int, barcode: String, nickname : String) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection, using the barcode serial number as its unique ID
        db.collection("Inventory").document(barcode).setData(["brand": brand, "type": type, "stock": stock]) {error in
        // db.collection("tasks").addDocument(data: ["name": name, "completed": completed]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call getData to update the UI with the latest data
                self.getData()
            }
            else {
                // Handle the error
                // EDIT later
            }
        }
        
    }
    
//    func deleteData(toDelete: Inv) {
//
//        // Get a reference
//        let db = Firestore.firestore()
//
//        // Specify the document to delete
//        // db.collection("tasks").document(toDelete.id).delete()
//        db.collection("tasks").document(toDelete.id).delete { error in
//            // Check for errors
//            if error == nil {
//                // No errors
//
//                // Update te UI from the main threade
//                DispatchQueue.main.async {
//
//                    // This will iterate over the list, and for each item, it will compare its id, then delete it if it's a match
//                    self.list.removeAll { todo in
//                        // Check for the todo to remove
//                        return todo.id == toDelete.id
//                    }
//                }
//            }
//        }
//    }
    
    
}
