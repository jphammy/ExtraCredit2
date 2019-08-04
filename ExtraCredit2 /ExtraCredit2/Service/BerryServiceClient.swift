import Foundation

/*** 1 ***/

struct BerryList: Decodable {
    let items: [URL]              //let results: [NameUrlPair]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let nameUrlArray = try container.decode([NameUrlPair].self, forKey: .items)
        items = nameUrlArray.compactMap {
            return $0.url
        }
    }
}

struct Berry: Decodable {
    let id: Int
    let growthTime: Int
    let maxHarvest: Int
    let naturalGiftPower: Int
    let size: Int
    let smoothness: Int
    let soilDryness: Int
    let firmness: String            //NameUrlPair
    let flavors: [BerryFlavorMap]
    let item: String                //NameUrlPair
    let naturalGiftType: String     //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case id
        case growthTime = "growth_time"
        case maxHarvest = "max_harvest"
        case naturalGiftPower = "natural_gift_power"
        case size
        case smoothness
        case soilDryness = "soil_dryness"
        case firmness
        case flavors
        case item
        case naturalGiftType = "natural_gift_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        growthTime = try container.decode(Int.self, forKey: .growthTime)
        maxHarvest = try container.decode(Int.self, forKey: .maxHarvest)
        naturalGiftPower = try container.decode(Int.self, forKey: .naturalGiftPower)
        size = try container.decode(Int.self, forKey: .size)
        smoothness = try container.decode(Int.self, forKey: .smoothness)
        soilDryness = try container.decode(Int.self, forKey: .soilDryness)
        flavors = try container.decode([BerryFlavorMap].self, forKey: .flavors)
        
        let firmnessNameUrl = try container.decode(NameUrlPair.self, forKey: .firmness)
        firmness = firmnessNameUrl.name
        
        let itemNameUrl = try container.decode(NameUrlPair.self, forKey: .item)
        item = itemNameUrl.name
        
        let naturalGiftTypeNameUrl = try container.decode(NameUrlPair.self, forKey: .naturalGiftType)
        naturalGiftType = naturalGiftTypeNameUrl.name
    }
}

struct BerryFlavorMap: Decodable {
    let potency: Int
    let flavor: String              //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case potency
        case flavor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        potency = try container.decode(Int.self, forKey: .potency)
        let flavorNameUrl = try container.decode(NameUrlPair.self, forKey: .flavor)
        flavor = flavorNameUrl.name
    }
}

/*** 2 ***/

// Complete result typealias' here
typealias BerryListResult = Result<BerryList, ServiceCallError>
typealias BerryResult = Result<Berry, ServiceCallError>

final class BerryServiceClient {
    private let baseServceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServceClient = baseServceClient
        self.urlProvider = urlProvider
    }

    /*** 3 ***/
    
    // Complete problem 2 before beginning this section so that the real function signature may be un-commented
    func getBerryList(completion: @escaping (BerryListResult) -> ()) {//(completion: @escaping (BerryListResult) -> ()) {
        let pathComponents = ["berry"]
        let parameters = ["offset": "\(0)", "limit": "\(64)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        // Write function body here
        baseServceClient.get(from: url) { (result) in
            switch result {
            case .success(let data):
                guard let berryList = try? JSONDecoder().decode(BerryList.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse json", code: nil)))
                    return
                }
                
                completion(.success(berryList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /*** 4 ***/
    
    // Complete problem 2 before beginning this section so that the real function signature may be un-commented
    func getBerry(id: Int, completion: @escaping (BerryResult) -> ()) {//(id: Int, completion: @escaping (BerryResult) -> ()) {
        let pathComponents = ["berry", "\(id)"]
        let parameters: [String: String] = [:]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
        baseServceClient.get(from: url) { (result) in
            switch result {
            case .success(let data):
                guard let berry = try? JSONDecoder().decode(Berry.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse json", code: nil)))
                    return
                }
                
                completion(.success(berry))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
