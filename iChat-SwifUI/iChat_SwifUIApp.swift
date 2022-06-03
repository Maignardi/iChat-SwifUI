//
//  iChat_SwifUIApp.swift
//  iChat-SwifUI
//
//  Created by Matheus Mendonça Maignardi on 07/05/22.
//

import SwiftUI
import Firebase

@main
struct iChat_SwifUIApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
