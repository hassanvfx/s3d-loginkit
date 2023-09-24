//
//  ContentView.swift
//  DemoApp
//
//  Created by hassan uriostegui on 8/30/22.
//

import SwiftUI
import S3DCoreUI

public struct LoginView: View {
    @ObservedObject var model=LoginViewModel()
    
    @State var phone:String=""
    @State var code:String=""
    
    public init(model: LoginViewModel? = nil, phone: String? = nil, code: String? = nil) {
        self.model = model ?? self.model
        self.phone = phone ?? self.phone
        self.code = code ?? self.code
    }
    
    public var body: some View {
        VStack{
            Text("LoginKit")
                .font(.title)
                .padding()
        
            Text("Phone Number")
                .font(.caption)
                .frame(maxWidth:.greatestFiniteMagnitude,alignment: .leading)
            TextField("Phone Number", text: $phone)
                .keyboardType(.phonePad)
                .padding()
                .background(Style.spec.palette.primary)
                .foregroundColor(Style.spec.palette.primary.contrastForeground)
            
            if model.hasRequestedCode {
                requestedCodeContent()
            } else {
                defaultContent()
            }
        }
        .padding(Style.spec.padding * 4)
        .background(Style.spec.palette.background)
        .foregroundColor(Style.spec.palette.background.contrastForeground)
        .frame(maxWidth:.greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .overlay(
            loadingOverlay()
                .opacity(model.loading ? 1 : 0)
        )
    }
}

extension LoginView{
    @ViewBuilder
    func loadingOverlay()->some View{
        VStack{
         Spacer()
            Text("Loading...")
                .bold()
                .font(.title)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth:.greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .background(Color.black.opacity(0.75))
        .foregroundColor(.white)
        
    }
}

extension LoginView{
    
    @ViewBuilder
    func defaultContent()->some View{
        Group{
            Button(action: { model.requestCode(phone: phone) } ){
                Text("Request Code")
                    .padding()
                    .background(Style.spec.palette.background)
                    .foregroundColor(Style.spec.palette.background.contrastForeground)
            }
            .padding(.top)
        }
    }
    
    @ViewBuilder
    func requestedCodeContent()->some View{
        Group{
            Text("Verification Code")
                .font(.caption)
                .frame(maxWidth:.greatestFiniteMagnitude,alignment: .leading)
            TextField("Verification Code", text: $code)
                .padding()
                .background(Style.spec.palette.primary)
                .foregroundColor(Style.spec.palette.primary.contrastForeground)
            
            Button(action: { model.validateCode(phone: phone, code: code) } ){
                Text("Verify Code")
                    .padding()
                    .background(Style.spec.palette.background)
                    .foregroundColor(Style.spec.palette.background.contrastForeground)
            }
            .padding(.top)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
