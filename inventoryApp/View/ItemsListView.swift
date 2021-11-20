//
//  ItemsList.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-19.
//

import SwiftUI
import Firebase

struct ItemsListView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if model.list.isEmpty {
                    Text("אין פריטים במלאי")
                }
                
                else {
                    NavigationLink(destination: ItemOptionsView(showOptions: $model.showItemOptions), isActive: $model.showItemOptions) { EmptyView() }
                    
                    Form {
                        Section(header: Text("בחר פריט")) {
                            List(model.list) { item in
                                HStack {
                                    Button {
                                        model.fetchItem(barcode: item.id)
                                    } label: {
                                        Image(systemName: "pencil")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .foregroundColor(Color(UIColor.systemBlue))
                                    Spacer()
                                    Text(item.nickname)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("פריטים במלאי")
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
    }
}
