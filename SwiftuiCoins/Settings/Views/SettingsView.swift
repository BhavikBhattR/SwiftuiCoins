//
//  SettingsView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 31/01/23.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let linkedinURL = URL(string: "https://github.com/BhavikBhattR")!
    let githubURL = URL(string: "https://www.linkedin.com/in/bhavik-bhatt-7b7785227/")!
    @State private var showMoreAppDescription = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            List{
              Credits
              CoinGeckoSection
              developerSection
              applicationSection
            }
            .font(.headline)
            .listStyle(GroupedListStyle())
            .tint(.blue)
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) { xMarkButton }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView{
    
    private var Credits: some View{
        Section{
            VStack(alignment: .leading, spacing: 4){
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("This app was made for learning purposes by Bhavik Bhatt. All the credits go to nick from @SwiftFul thinking for the amazing course dedicated to teach the design and building of this app on youtube.\n\nThis app was made using the MVMM architecture, combine and core data")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accent)
                .lineLimit(showMoreAppDescription ? nil : 3)
                Button{
                    showMoreAppDescription.toggle()
                }label: {
                    Text(showMoreAppDescription ? "Less" : "Read more ..")
                }.tint(.blue)
        }
            Link("Check out swiftful thinking", destination: youtubeURL)
        }header: {
            Text("Credits")
        }
    }
    
    private var CoinGeckoSection: some View{
        Section{
            VStack(alignment: .leading, spacing: 4){
            Image("coingecko")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("Cryptocurrency data displayed in this app comes from the free api named CoinGecko. It is a free api ! Data might get loaded with slight delay. ")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accent)
        }
            Link("Visit coingecko api", destination: coinGeckoURL)
        }header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View{
        Section{
            VStack(alignment: .leading, spacing: 4){
            Image("developer")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("I am a CS graduate. I develop interesting apps with swiftui. I try to add value in people's life through my creation. This app was completely made for learning purposes by the guidance of swiftful thinking channel on youtube.")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.accent)
        }
            Link("Visit my github profile", destination: githubURL)
            Link("Contact me on linkedin", destination: linkedinURL)
        }header: {
            Text("Developer")
        }
    }
    
    private var applicationSection: some View{
        Section{
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }header: {
            Text("Application")
        }
    }
    
    private var xMarkButton: some View{
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
    
}
