//
//  FilterBarView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct FilterBarView: View {
    var barItems:[String]
    @State var selectedItem:Int = 0
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 20){
                ForEach(0...barItems.count - 1, id: \.self){ index in
                    FilterBarItem(title: barItems[index], isSelected: (selectedItem == index))
                        .onTapGesture {
                            selectedItem = index
                        }
                }
            }
        }
    }
}

struct FilterBarItem: View {
    var title: String
    var isSelected: Bool
    var body: some View {
        VStack{
            Text(title)
                .foregroundColor(Color.white)
            Rectangle()
                .fill(isSelected ? Color.white : Color(Constants.UIColors.defaultBackgroundColor))
                .frame(height: 3)
        }
    }
}
