//
//  GeometryReaderBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 29.09.2024.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    // Fonksiyonun açıklaması.
    /*
     currentX / maxDistance ifadesi, öğenin ekranın ortasına göre ne kadar uzak olduğunu hesaplar.
     Eğer öğe ekranın tam ortasındaysa, currentX / maxDistance = 1 olur.
     Eğer öğe ekranın ortasından uzaktaysa, bu değer 1'den küçük olur (örneğin, kenara yaklaştıkça 0'a yaklaşır).
     1 - (currentX / maxDistance) ifadesiyle bu oran tersine çevrilir. Yani:
     Ekranın tam ortasında olan bir öğe için sonuç 0 olur.
     Ekranın kenarına yaklaşan bir öğe için sonuç 1 olur.
     Sonuç olarak: Bu fonksiyon, öğenin ekranın ortasına göre ne kadar uzak olduğunu hesaplar ve bu uzaklığı bir oran olarak döner. Bu oran, rotation3DEffect'te döndürme açısı olarak kullanılır.
     */
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        
        // MARK: Reel word example
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 10)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                        axis: (x: 0.0, y: 0.1, z: 0.0)
                            )
                        
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
        // MARK: Basic usage
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.red)
//                    //This usage not adaptive with landscape mode.
////                    .frame(width: UIScreen.main.bounds.width * 0.66666)
//                    .frame(width: geometry.size.width * 0.66666)
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
}

#Preview {
    GeometryReaderBootcamp()
}
