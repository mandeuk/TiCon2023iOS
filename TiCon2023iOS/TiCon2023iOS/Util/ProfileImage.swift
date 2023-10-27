//
//  ProfileImage.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import PhotosUI

struct ProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.black)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    let imageState: ProfileModel.ImageState
    let width: Float
    let height: Float
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: CGFloat(width) , height: CGFloat(height))
            .background {
                Circle().fill(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                
//                Circle().fill(
//                    LinearGradient(
//                        colors: [.yellow, .orange],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
            }
    }
}

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    let width: Float
    let height: Float
    
    var body: some View {
        
        PhotosPicker(selection: $viewModel.imageSelection,
                     matching: .images,
                     photoLibrary: .shared()) {
            CircularProfileImage(imageState: viewModel.imageState, width: width, height: height)
        }
        .buttonStyle(.borderless)
        
        
        
//        CircularProfileImage(imageState: viewModel.imageState, width: width, height: height)
//            .overlay(alignment: .bottomTrailing) {
//                PhotosPicker(selection: $viewModel.imageSelection,
//                             matching: .images,
//                             photoLibrary: .shared()) {
//                    Image(systemName: "pencil.circle.fill")
//                        .symbolRenderingMode(.multicolor)
//                        .font(.system(size: 30))
//                        .foregroundColor(.accentColor)
//                }
//                             .buttonStyle(.borderless)
//            }
    }
}

