//
//  SwiftUIView.swift
//  
//
//  Created by Farid Azhari on 06/04/23.
//

import SwiftUI

struct InfoView: View {
    var history = historyList()
    let formatter = DateFormatter()
    
    var body: some View {
        NavigationView{
            Text("")
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.145, green: 0.145, blue: 0.145))
                .overlay(
            VStack(){
                Text("Credits").frame(maxWidth: .infinity).padding().background(Color.black)
                    .foregroundColor(Color.white)
                Spacer()
                Image("motor")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top)
                Text("Motorcycle PNG Designed By Pugazh Productions\r\n")
                    .font(.callout)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing])
                Text("https://pngtree.com/freepng/luxurious-superbike-motorcycle-front-view-vector-design_5679834.html?sol=downref&id=bef").font(.caption)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing, .bottom])
                Spacer()
            })
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
            InfoView()
    }
}
 

