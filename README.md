# LoginKit
![Demo](https://github.com/hassanvfx/s3d-loginkit/assets/425926/960d30d9-ae4e-40df-b553-6f233fa5df38)

This repository is part of a larger demo project called the Simple3D Viewer. You can find the main project [here](https://github.com/hassanvfx/simple3DViewer).

LoginKit is a module that links the CoreUI, CoreModels, and BaseAPI to create a mocked signing flow. The module requires an optional completion callback that will return the final SessionItem to the original callsite.

This framework was built with the [ios-framework config tool](https://github.com/hassanvfx/ios-framework).

## LoginViewModel

The LoginViewModel is a key component of this module. It uses SwiftUI, S3DBaseAPI, and S3DCoreModels.

```swift
import SwiftUI
import S3DBaseAPI
import S3DCoreModels

@MainActor
public class LoginViewModel:ObservableObject{
    var api = BaseAPI(mocking: true)
    var completion:LoginViewModelCompletion?
    ...
}
```

The LoginViewModel includes functions to request a code and validate a code.

```swift
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
```

For more details, please refer to the source code.
