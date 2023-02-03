//
//  MenuView.swift
//  Menu
//
//  Created by Gustavo Araujo Santos on 13/12/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    View1()
                } label: {
                    Text("Screen 1")
                }

                NavigationLink {
                    View2()
                } label: {
                    Text("Screen 2")
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
