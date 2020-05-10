//
//  WeatherRequestViewModel.swift
//  123
//
//  Created by gdml on 13/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwiftyJSON

final class MainControllerViewModel: NSObject, Alias {
    
    fileprivate var locationManager: LocationManager?
    private var NetworkService: NetworkService
    var completion: type?
    private(set) var weather = [Convertible]()
    var dates = [String]()
    
    private let dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    func byLocation(lat: Double, lon: Double) {
        
        let Operator = Init(test: Test(str: nil, key: nil, lat: lat, lon: lon))
        
        NetworkService.request(router: Operator.geoLocate()) { [weak self] data in
            if let key = data["Key"].string {
                guard let int = Int(key) else { return }
                self?.weatherFiveDayRequest(key: int) { item, one in
                    self?.weather = item
                    self?.completion?(item,one)
                }
            }
        }
    }
    
     func weatherFiveDayRequest(key: Int,completion: @escaping (type)) {
           
           let Operator = Init(test: Test(str: nil, key: key, lat: nil, lon: nil))
           
           NetworkService.request(router: Operator.getWeather()) { [unowned self] data in
               let array = data["DailyForecasts"].arrayValue
               let WeatherModel = array.map { DailyForecast(dictionary: $0) }
               let weatherX = zip(WeatherModel,self.dates).map { [unowned self] (first,second) -> Convertible in
                   return Convertible(date: self.format(data: first.date),
                                      temperature: first.temperature.convertToCelsius(),
                                      dayIcon: first.dayIcon,
                                      dayIconPhrase: first.dayIconPhrase,
                                      nightIconPhrase: first.nightIconPhrase,
                                      realFeel: first.realFeel,
                                      wind: first.wind,
                                      standardDate: second)
                   
               }
               self.weather = weatherX
               completion(weatherX, weatherX[0])
           }
       }
    
    
    
    func numberOfCities() -> Int {
        return weather.count
    }
    
    func cellViewModel(index: Int) -> Convertible? {
        return weather[index]
    }
    
    func returnit() {
        dates.append("Сегодня")
        dates.append("Завтра")
        for item in 2...4 {
            let data = Calendar.current.date(byAdding: .day, value: item, to: Date(), wrappingComponents: .random())!
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "EEEE"
            let finish = dateFormatterPrint.string(from: data)
            dates.append(finish)
        }
    }
    
    init(data: NetworkService) {
        self.NetworkService = data
        super.init()
        returnit()
        locationManager = LocationManager(locationResponse: { item in
            self.byLocation(lat: item.coordinate.latitude, lon: item.coordinate.latitude)
        })
    }
}

extension MainControllerViewModel {
    
    func format(data: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        guard let date: Date = dateFormatter.date(from: data) as Date? else { return String()}
        let finish = dateFormatterPrint.string(from: date)
        return finish
    }
}
