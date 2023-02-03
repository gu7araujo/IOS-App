//
//  SwiftUIView2.swift
//  App_DEV
//
//  Created by Gustavo Araujo Santos on 02/02/23.
//

import SwiftUI

struct SwiftUIView2: View {

    enum Words: String {
        case title = "O cadastro do seu estabelecimento foi enviado!"
        case contact = "Logo entraremos em contato com você!"
        case contactDescription = "Assim que seu cadastro comercial for verificado e aprovado, você receberá uma confirmação via e-mail ou mensagem de texto com um link para completar seu processo."
        case buttonBack = "Voltar para o início"
        case doubts = "Dúvidas? Ligue para a Central de Atendimento Parceiro BEES"
        case time = "De segunda á sábado, das 08h ás 12h"
        case cellPhone = "Telefone:"
        case cellPhoneNumber = "0800 887 11111"
        case whatsApp = "WhatsApp:"
        case whatsAppNumber = "+55 800 591 1540"
    }

    var body: some View {
        VStack {
            Text(Words.title.rawValue)
                .font(.headline)
                .fontWeight(.bold)
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 30)

            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 200, height: 200)
                .padding(.bottom, 30)

            Text(Words.contact.rawValue)
                .font(.system(size: 20))
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 5)

            Text(Words.contactDescription.rawValue)
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 30)

            Button {

            } label: {
                Text(Words.buttonBack.rawValue)
                    .underline()
            }
            .padding(.bottom, 30)

            VStack {
                Text(Words.doubts.rawValue)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .padding([.bottom, .top], 5)

                Text(Words.time.rawValue)
                    .font(.system(size: 13))
                    .padding(.bottom, 5)

                HStack {
                    Text(Words.cellPhone.rawValue)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    Text(Words.cellPhoneNumber.rawValue)
                        .underline()
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .foregroundColor(.blue)
                }

                HStack {
                    Text(Words.whatsApp.rawValue)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    Text(Words.whatsAppNumber.rawValue)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray)

            Spacer()
        }
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView2()
    }
}
