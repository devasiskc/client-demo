//
//  DemoViewModel.swift
//  Demo Task
//
//  Created by Devasis KC on 25/11/2023.
//

import Foundation
import Combine

class DemoViewModel: ObservableObject {
    
    @Published var data: DemoModel?
    @Published var error: APIError?
    
    private var cancellable: AnyCancellable?
    
    
    //MARK: ASYNC AWAIT FUNC
    func fetchData() async {
        do {
            let url = URL(string: Constants.baseURL)!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodeData = try JSONDecoder().decode(DemoModel.self, from: data)
            
            DispatchQueue.main.async {
                self.data =  decodeData
            }
            
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    //MARK: Combine Function
    func fetchData1() {
        guard let url = URL(string: Constants.baseURL) else {
            print("Invalid URL")
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DemoModel.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    print("Data fetched successfully")
                }
            } receiveValue: { data in
                self.data = data
            }
        
    }
    
    //MARK: Generic API service func
    func fetchDataGeneric() async {
        guard let apiUrl = URL(string: Constants.baseURL) else {
            self.error = .invalidURL
            return
        }
        
        do {
            let data:DemoModel = try await APIService.fetchData(url: apiUrl)
            DispatchQueue.main.async {
                self.data = data
            }
            
        } catch {
            self.error = error as? APIError
        }
    }
    
}
