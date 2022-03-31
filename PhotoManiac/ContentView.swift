//
//  ContentView.swift
//  PhotoManiac
//
//  Created by Tatsuya Moriguchi on 3/31/22.
//

import SwiftUI

// https://random.imagecdn.app/500/500

class ViewModel: ObservableObject {
    //To communicate with view got the data
    @Published var image: Image?

    func fetchNewImage() {
        
        
        
        guard let url = URL(string: "https://random.imagecdn.app/500/500") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, url, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                if let image = viewModel.image {
                    image
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200, height: 200)
                        .padding()
                } else {
                    
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.pink)
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                }
                Spacer()
                
                Button(action: {
                    viewModel.fetchNewImage()
                }, label: {
                    Text("Now Image!")
                        .bold()
                        .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                    
                    
                    
                })
            }
            .navigationTitle("Photo Mania")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
