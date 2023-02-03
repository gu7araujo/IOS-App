//
//  SwiftUIView3.swift
//  App_DEV
//
//  Created by Gustavo Araujo Santos on 03/02/23.
//

import SwiftUI

struct View2: View {

    @State var fieldText = ""

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, maxHeight: 200)

            VStack {
                Text("Text text text text")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)

                Text("Text text text text text text text text text text text text text text text text text text text text text text text text text text text text text")
                    .frame(maxWidth: .infinity, alignment: .leading)

                CustomTextField(placeholder: "000.000.000-00", stringOfTextField: $fieldText)
                    .padding(.bottom, 30)

                CustomButton()
            }.padding([.leading, .trailing], 20)

            Spacer()
        }
        .navigationBarTitle(Text("Screen 2"), displayMode: .inline)
    }
}

struct View2_Previews: PreviewProvider {
    static var previews: some View {
        View2()
    }
}

struct CustomButton: View {
    var body: some View {
        HStack {
            Spacer()

            Text("Next")
                .foregroundColor(.white)
                .font(.headline)

            Spacer()

            Button {

            } label: {
                Text("here")
            }
            .frame(maxWidth: 40, maxHeight: 40)
            .background(Color.yellow)
            .cornerRadius(50)
            .padding(.trailing, 10)
        }
        .frame(maxWidth: 120, maxHeight: 50)
        .background(Color.black).clipShape(Capsule())
    }
}

struct CustomTextField: View {

    var placeholder: String
    @Binding var stringOfTextField: String

    var body: some View {
        TextField(placeholder, text: $stringOfTextField)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
    }
}
