//
//  ContentView.swift
//  OnTextChange
//
//  Created by Nayak on 4/27/24.
//

import SwiftUI

class User : ObservableObject{
    @Published var name : String = String()
}
//struct User{
//    var name : String = String()
//}
struct ContentView: View {
//        @State var user = User()
        @ObservedObject var user = User()
        var body: some View{
            VStack{
            List{
                TextField("name:",text:$user.name,onEditingChanged: getFocus)
                
            }
            Spacer()
            Text(user.name)
            }
        }

        func getFocus(focused:Bool) {
            print("get focus:\(focused ? "true" : "false")")
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
