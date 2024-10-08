//
//  Publisher&SubscriberBootcamp.swift
//  SwiftUIMidLevelBootcamp
//
//  Created by Oğuzhan Abuhanoğlu on 8.10.2024.
//

import SwiftUI
import Combine

class PublisherViewModel: ObservableObject {
    
    @Published var count: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    @Published var textfieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    
    // What is debounce
    /*
     .debounce(for: 0.5, scheduler: DispatchQueue.main)
     Debounce, bir olayın tetiklenmesini, belirli bir süre içinde ikinci bir olay gerçekleşmediği sürece geciktiren bir tekniktir. Örneğin, kullanıcı bir düğmeye hızlı bir şekilde tıklarsa, debouncing sayesinde yalnızca en son tıklama dikkate alınır. Bu, gereksiz işlem yükünü azaltır ve daha iyi bir performans sağlar.
     */
    func addTextFieldSubscriber() {
        $textfieldText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                guard text.count > 3 else { return false }
                return true
            }
//            .assign(to: \.textIsValid, on: self)
            .sink { [weak self] isValid in
                self?.textIsValid = isValid
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 5 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    
    
}

struct PublisherAndSubscriberBootcamp: View {
    
    @StateObject var vm = PublisherViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
                .padding()
            
            Divider()
            
            Text("\(vm.textIsValid.description)")
            
            TextField("Type something here...", text: $vm.textfieldText)
                .padding(.leading)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).cornerRadius(10))
                .padding()
            
            Button {
                
            } label: {
                Text("submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)

                
        }
    }
}

#Preview {
    PublisherAndSubscriberBootcamp()
}
