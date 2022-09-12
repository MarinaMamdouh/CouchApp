//
//  BackdropMovieImage.swift
//  Couch
//
//  Created by Marina on 12/09/2022.
//

import SwiftUI

struct BackdropMovieImage: View {
    @Binding var image: UIImage?
    @State var opacity = 0.8
    private let loadingAnimation = Animation.easeInOut(duration: 1)
    var body: some View {
        VStack{
            if let image = self.image {
                downloadedimageView(image)
            }else{
                loadingImageBox
            }
        }
    }
    
    func  downloadedimageView(_ image: UIImage)-> some View{
        ZStack(alignment: .topTrailing) {
            Image(uiImage:  image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .opacity(0.8)
                .shadow(color: .black, radius: 30, x: 0, y: 5)
            
        }
    }
    
    var loadingImageBox: some View{
        Rectangle()
            .backDropImageSize()
            .loadingStyle()
            .cornerRadius(10)
            .opacity(opacity)
            .onAppear{
                startLoadingAnimation()
            }
    }
    
    func startLoadingAnimation(){
        withAnimation(
            loadingAnimation.repeatForever(autoreverses: true))
        {
            opacity = 0.3
        }
    }
}

struct BackdropMovieImage_Previews: PreviewProvider {
    static var previews: some View {
        
        BackdropMovieImage(image: .constant(nil))
            .previewLayout(.sizeThatFits)
            .background(Color.theme.background)
    }
}
