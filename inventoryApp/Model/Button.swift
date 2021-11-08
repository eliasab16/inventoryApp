//
//  Button.swift
//  inventoryApp
//
//  Created by Elias Abunuwara on 2021-11-08.
//

import Foundation
import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.white)
      Spacer()
    }
    .padding()
    .background(Color.blue.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
