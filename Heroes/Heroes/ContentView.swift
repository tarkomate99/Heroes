//
//  ContentView.swift
//  Heroes
//
//  Created by mac on 2023. 02. 21..
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 26, height: 26)
                .background(Color.orange)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(hex: 0xc82626), lineWidth: 1))
        }
        else {
            Image(systemName: "circle")
                .frame(width: 26, height: 26)
                .background(Color.orange)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .onAppear{
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data,_,_ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
            
            NavigationView{
                List{
                    ForEach(viewModel.heroes, id: \.self) { hero in
                        HStack{
                            URLImage(urlString: hero.imageURL, data: nil)
                            Text(hero.name)
                                .font(.system(size: 17))
                            NavigationLink(destination: MapView(hero: hero)){
                                EmptyView()
                            }
                        }
                    }
                }
                .navigationTitle("Heroes")
                .onAppear{
                    viewModel.fetch()
                }
            }
            
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
