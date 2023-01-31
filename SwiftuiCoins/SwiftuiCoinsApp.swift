//
//  SwiftuiCoinsApp.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 12/01/23.
//

import SwiftUI

@main
struct SwiftuiCoinsApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView:Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack{
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                        .environmentObject(vm)
                }
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }.zIndex(2.0)
            }
        }
    }
}
