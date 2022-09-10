//
//  FavoriteIcon.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import SwiftUI

struct FavoriteIcon: View {
    @Binding var isOn: Bool
    var body: some View {
        Image(systemName: isOn ? "heart.fill" : "heart")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(Color.theme.red)
            .shadow(color: Color.theme.shadow, radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct FavoriteIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            
            FavoriteIcon(isOn: .constant(false))
                .background(Color.theme.background)
                .previewLayout(.sizeThatFits)
            FavoriteIcon(isOn: .constant(true))
                .background(Color.theme.background)
                .previewLayout(.sizeThatFits)
        }
    }
}
