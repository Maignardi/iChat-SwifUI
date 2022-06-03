//
//  SingUpViewModel.swift
//  iChat-SwifUI
//
//  Created by Matheus Mendonça Maignardi on 07/05/22.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class SignUpViewModel: ObservableObject{
    
    var email = ""
    var password = ""
    var name = ""
    
    @Published var image = UIImage()
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    func singUp(){
        
        if(image.size.width <= 0){
            formInvalid = true
            alertText = "Selecione uma foto"
            return
        }
        
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password){
            result, err in
            guard let user = result?.user, err == nil else{
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                print(err)
                self.isLoading=false
                return
            }
            self.isLoading = false
            print("Usuario criado \(user.uid)")
            
            self.uploadPhoto()
            
        }
    }
    private func uploadPhoto(){
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else{ return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata){ metadata, err in
            ref.downloadURL{url, error in
                self.isLoading = false
                print("foto criada \(url)")
            }
        }
    }
}
