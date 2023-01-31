//
//  SearchBarView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 27/01/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState var isKeyBoardFocused: Bool
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryTextColor : Color.theme.accent)
            TextField("Search By name or symbol ...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled()
                .keyboardType(.default)
                .focused($isKeyBoardFocused)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        searchText = ""
                        isKeyBoardFocused = false
                    }
                , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
