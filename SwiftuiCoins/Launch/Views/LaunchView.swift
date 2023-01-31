//
//  LaunchView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 31/01/23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading crypto world...".map{ String($0)}
    @State private var showingLoadText: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var count = 0
    @State private var loops = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack{
            Color.launchColorTheme.launchBackgroundColor
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack{
                HStack(spacing: 0){
                    ForEach(loadingText.indices, id: \.self){ index in
                        Text(loadingText[index])
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.launchColorTheme.launchAccentColor)
                            .offset(y: index == count ? -5 : 0 )
                    }
                }
                .transition(AnyTransition.scale.animation(.easeIn))
            }
            .offset(y: 70)
        }
        .onAppear{
            showingLoadText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()){
                if count == loadingText.count - 1{
                    loops += 1
                    count = 0
                    
                    if loops >= 2{
                        showLaunchView = false
                    }
                }else{
                    count += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
