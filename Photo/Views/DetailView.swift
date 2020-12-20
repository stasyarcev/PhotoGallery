//
//  DetailView.swift
//  Photo
//
//  Created by Стас Ярцев on 19.12.2020.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(width: 100, height: 5)
                .cornerRadius(30)
                .foregroundColor(Color.black.opacity(0.3))
            DetailTop()
            Spacer()
        }.padding(.top, 8)
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(30)
        .shadow(radius: 10)
        .offset(x: 0, y: UIScreen.main.bounds.height-100)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct DetailTop: View {
    @State var like = false
    
    var body: some View {
        
        HStack(spacing: 30) {
            Spacer()
            
            HStack {
                Button(action: {
                    self.like.toggle()
                }) {
                    HStack {
                        Image(systemName: self.like == false ? "suit.heart" : "suit.heart.fill")
                    }
                    
                }
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "link")
            }
            Button(action: {
                
            }) {
                Image(systemName: "ellipsis")
            }
            
            Spacer()
        }
        .padding()
    }
}
