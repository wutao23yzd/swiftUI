//
//  ContentView.swift
//  helloswiftUI2
//
//  Created by admin on 2024/2/18.
//

import SwiftUI
import Combine

class LoginVM: ObservableObject {

    @Published var phoneNum:String = "" {
        didSet {
            if phoneNum.count > 11 {
                phoneNum = String(phoneNum.prefix(11))
            }
        }
    }
    @Published var password:String = ""
}

struct ContentView: View {
    @StateObject private var model:LoginVM = LoginVM()
    
    var statusBarHeight: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes
                   .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
        return windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    var body: some View {
        VStack(alignment: .center,
               spacing: 0,
               content: {
            Text("欢迎登录")
                .font(.system(size: 26, weight: .semibold))
                .padding(.top, 44 + 62)
            
            VStack(spacing: 0, content: {
                HStack(content: {
                    Text("+86")
                    Image("downArrow")
                    TextField("请输入手机号", text: $model.phoneNum)
                        .keyboardType(.numberPad)
                }).frame(height: 48)
                Divider().frame(height: 1)
            })
            .padding(.top, 50)
            
 
            VStack(spacing: 0, content: {
                TextField("请输入密码", text: $model.password).frame(height: 48)
                Divider().frame(height: 1)
            })
            .padding(.top, 18)
    
            
            
            HStack(content: {
                Button(action: {}, label: {
                    Text("验证码登录")
                        .foregroundStyle(.black)
                        .font(.system(size: 14))
                })
                Spacer()
                Button(action: {}, label: {
                    Text("忘记密码？")
                        .foregroundStyle(.black)
                        .font(.system(size: 14))
                })
            })
            .frame(height: 40)
            .padding(.top, 14)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("登录")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .padding(.vertical, 14)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(24)
            })
            .padding(.top, 21)
            
            Spacer()
            
            HStack(spacing: 0, content: {
                Image("select")
                Text("代表您同意")
                    .font(.system(size: 13))
                Text("用户协议")
                    .font(.system(size: 13))
                    .foregroundStyle(.yellow)
                Text("和")
                    .font(.system(size: 13))
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("隐私政策")
                        .font(.system(size: 13))
                        .foregroundStyle(.yellow)
                })
            })
            .padding(.bottom, 20)
        })
        .padding(.top, statusBarHeight)
        .padding(.horizontal, 20)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
