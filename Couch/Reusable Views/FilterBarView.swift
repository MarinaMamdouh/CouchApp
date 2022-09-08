//
//  FilterBarView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct FilterBarView: View {
    @Binding var selectedItem:Int
    var barItems:[String]
    var body: some View {
        ScrollView(.horizontal){
            content
        }
        .padding()
    }
}

extension FilterBarView{
    var content: some View {
        HStack(spacing: 20){
            ForEach(barItems.indices, id: \.self){ index in
                FilterBarItem(title: barItems[index], isSelected: (selectedItem == index))
                    .onTapGesture {
                        selectedItem = index
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
                .foregroundColor(Color.theme.primary)
                
                .font(.title2)
            Rectangle()
                .fill(isSelected ? Color.theme.primary : Color.theme.background)
                .frame(height: 3)
        }
    }
}

struct FilterBarView_Previews: PreviewProvider {
    static let filterBarItems = ["Most Popular", "Top Rated", "New" ]
    static var previews: some View {
        FilterBarView(selectedItem: .constant(0), barItems: ["Most Popular", "TopRated", "New"])
            .background(Color.theme.background)
            .previewLayout(.sizeThatFits)
        
    }
}


