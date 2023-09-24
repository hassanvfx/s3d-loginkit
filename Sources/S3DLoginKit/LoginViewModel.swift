//
//  LoginViewModel.swift
//  DemoApp
//
//  Created by Eon Fluxor on 9/23/23.
//

import SwiftUI
import S3DBaseAPI
import S3DCoreModels

public typealias LoginViewModelCompletion = (SessionItem) -> Void

@MainActor
public class LoginViewModel:ObservableObject{
    var api = BaseAPI(mocking: true)
    var completion:LoginViewModelCompletion?
    @Published var requestedCodePhone:String?
    @Published var loading=false
    public init(api: BaseAPI? = nil, completion: LoginViewModelCompletion? = nil, requestedCodePhone: String? = nil, loading: Bool = false) {
        self.api = api ?? self.api
        self.completion = completion
        self.requestedCodePhone = requestedCodePhone
        self.loading = loading
    }
}

public extension LoginViewModel{
    var hasRequestedCode:Bool{
        requestedCodePhone != nil
    }
    func reset(){
        loading=false
        requestedCodePhone = nil
    }
}

public extension LoginViewModel{
    func requestCode(phone:String){
        Task{
            loading=true
            guard await api.requestCode(phoneNumber: phone) == true else {
                reset()
                UIApplication.presentAlert(title: "Invalid PhoneNumber", message: "Please try again")
                return
            }
            loading=false
            requestedCodePhone = phone
        }
        
    }
    func validateCode(phone:String,code:String){
        Task{
            loading=true
            guard let session = await api.validateCode(phoneNumber: phone, code: code) else {
                reset()
                return
            }
            reset()
            
            guard let completion = completion else {
                UIApplication.presentAlert(title: "Success", message: session.token ?? "no token")
                return
            }
            completion(session)
            
        }
    }
}


