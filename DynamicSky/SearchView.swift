//
//  SearchView.swift
//  DynamicSky
//
//  Created by Derek Quinn on 2/15/21.
//

import SwiftUI

struct SearchView: View {
    @State var userEnteredZipCode: String = ""
    
    var body: some View {
        VStack{
            HStack{
                TextField("Enter a Zip Code", text: $userEnteredZipCode)
                    .padding()
                Image(systemName: "magnifyingglass").onTapGesture {
                    print("ZIP = \(userEnteredZipCode)")
                }
            }
            Spacer()
        }
        
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
