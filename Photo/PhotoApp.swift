//
//  PhotoApp.swift
//  Photo
//
//  Created by Стас Ярцев on 19.12.2020.
//

import SwiftUI

@main
struct PhotoApp: App {
    @State private var store = PhotoStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
