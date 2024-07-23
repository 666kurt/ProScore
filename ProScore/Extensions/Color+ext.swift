//
//  Color+ext.swift
//  ProScore
//
//  Created by Максим Шишлов on 21.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    struct TextColors {
        let main = Color("textMain")
        let notActive = Color("textNotActive")
        let second = Color("textSecond")
    }
    
    struct BackgroundColors {
        let light = Color("bgLight")
        let main = Color("bgMain")
        let second = Color("bgSecond")
    }
    
    struct OtherColors {
        let primary = Color("primary")
        let secondary = Color("secondary")
        let separator = Color("separator")
        let calendar = Color("calendarColor")
        let tabbar = Color("tabbarColor")
    }
    
    let text = TextColors()
    let background = BackgroundColors()
    let other = OtherColors()
    
}
