//
//  ViewModel.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-07.
//

import Foundation
import Firebase
import FirebaseAuth

class ViewModel: ObservableObject {
    
    @Published var list = [Inv]()
    
    // save the fetched item in the struct instance below
    //@Published var foundItem = Inv(id: "", brand: "", type: "", stock: 0, nickname: "")
    @Published var wasFound = false
    
    // Controlling different views
    @Published var showRegister = false
    @Published var showItemOptions = false
    
    // database connection properties
    @Published var barcodeValue = ""
    
    @Published var id = ""
    @Published var brand = ""
    @Published var type = ""
    @Published var stock = 0
    @Published var nickname = ""
    @Published var supplier = ""
    @Published var recQuantity = 0
    
    // log in properties
    @Published var loginError = false
    @Published var signedIn = false
    let auth = Auth.auth()
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    // fetch all data function

    func getData() {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the docu,emt at a specific path
        db.collection("Inventory").getDocuments { list, error in
            // check for errors
            if error == nil {
                if let list = list {

                    DispatchQueue.main.async {
                        // Get all the documents and create Inv structs
                        self.list = list.documents.map { doc in
                            // return an Inv struct. The attributes of the documents are accessed as key,items in a dictionary
                            return Inv(id: doc.documentID,
                                       brand: doc["brand"] as? String ?? "",
                                       type: doc["type"] as? String ?? "",
                                       stock: doc["stock"] as? Int ?? 0,
                                       nickname: doc["nickname"] as? String ?? "",
                                       supplier: doc["supplier"] as? String ?? "",
                                       recQuantity: doc["recQuantity"] as? Int ?? 0)
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
            
                self.barcodeValue = barcode
                
                if let doc = doc, doc.exists {
                    // Document exists
                    // Get relevant data
                    self.id = barcode
                    self.brand = doc["brand"] as? String ?? ""
                    self.type = doc["type"] as? String ?? ""
                    self.stock = doc["stock"] as? Int ?? 0
                    self.nickname = doc["nickname"] as? String ?? ""
                    self.supplier = doc["supplier"] as? String ?? ""
                    self.recQuantity = doc["recQuantity"] as? Int ?? 0

//                    self.foundItem = Inv(id: barcode,
//                                     brand: doc["brand"] as? String ?? "",
//                                     type: doc["type"] as? String ?? "",
//                                     stock: doc["stock"] as? Int ?? 0,
//                                     nickname: doc["nickname"] as? String ?? "")
                    
                    self.showItemOptions = true
                    self.showRegister = false
                } else {
                    // Document doesn't exist
                    self.showItemOptions = false
                    self.showRegister = true
                }
            }
        }
        
        
    }
    
    // Update the quantity in inventory of item "id"
    func updateQuantity(id: String, quantity: Int) {

        var newQuantity = self.stock + quantity
        
        // Get a reference to the database
        let db = Firestore.firestore()

        if (newQuantity < 0) {
            newQuantity = 0
        }
        
        db.collection("Inventory").document(id).updateData(["stock" : newQuantity])
    }
        
        
    // Get data to update the UI
    //self.getData()
    
    // Add item to inventory
    func addData(id: String, brand: String, type: String, stock: Int, nickname : String, supplier: String, recQuantity: Int) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection, using the barcode serial number as its unique ID
        db.collection("Inventory").document(id).setData(["brand": brand,
                                                         "type": type,
                                                         "stock": stock,
                                                         "nickname": nickname.isEmpty ? (brand + type) : nickname,
                                                         "supplier": supplier,
                                                         "recQuantity": recQuantity]) {error in
            
            // Check for errors
            if error == nil {
                // No errors
                
            }
            else {
                // Handle the error
                print("error")
            }
        }
        
    }
    
    // sign in function
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.loginError = true
                return
            }
            
            // added self"?" and [weak self] above to prevent any memory leaks
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    // sign out function
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
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

    
