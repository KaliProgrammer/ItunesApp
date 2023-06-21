//
//  BuyButtonView.swift
//  ItunesApp
//
//  Created by MacBook Air on 13.06.2023.
//

import SwiftUI

struct BuySongButtonView: View {
    let urlString: String?
    let price: Double?
    let currency: String?
    
    var body: some View {
        if let price = price {
            BuyButtonView(urlString: urlString, price: price, currency: currency)
        } else {
            Text("ALBUM ONLY")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}


struct BuyButtonView: View {
    let urlString: String?
    let price: Double?
    let currency: String?
   
    
    var body: some View {
        if let url = URL(string: urlString ?? ""),
           let priceString = formattedPrice() {
            Link(destination: url) {
                Text("\(priceString)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
    
    func formattedPrice() -> String? {
        
        guard let price = price else {
            return nil
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
       let priceString = formatter.string(from: NSNumber(value: price))
        
        
        
        return priceString
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let example = Album.example()
        BuyButtonView(urlString: example.artworkUrl60, price: example.collectionPrice, currency: example.currency)
    }
}
