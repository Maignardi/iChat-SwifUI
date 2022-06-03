//
//  SignInViewModel.swift
//  iChat-SwifUI
//
//  Created by Matheus Mendonça Maignardi on 07/05/22.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject{
    
    var email = ""
    var password = ""
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    func singIn(){
        print("email: \(email), senha: \(password)")
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password){
            result, err in
            guard let user = result?.user, err == nil else{
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                print(err)
                self.isLoading=false
                return
            }
            self.isLoading = false
            print("Usuario logado \(user.uid)")
        }
    }
    
}
