import Foundation

/*** 5 ***/

struct AbilityList: Decodable {
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

struct Ability: Decodable {
    let id: Int
    let name: String
    let isMainSeries: Bool
    let generation: String          //NameUrlPair
    let names: [Name]
    let effectEntries: [EffectEntry]
    let effectChanges: [EffectChange]
    let flavorTextEntries: [FlavorTextEntry]
    let pokemon: [PokemonForAbility]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMainSeries = "is_main_series"
        case generation
        case names
        case effectEntries = "effect_entries"
        case effectChanges = "effect_changes"
        case flavorTextEntries = "flavor_text_entries"
        case pokemon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isMainSeries = try container.decode(Bool.self, forKey: .isMainSeries)
        names = try container.decode([Name].self, forKey: .names)
        effectEntries = try container.decode([EffectEntry].self, forKey: .effectEntries)
        effectChanges = try container.decode([EffectChange].self, forKey: .effectChanges)
        flavorTextEntries = try container.decode([FlavorTextEntry].self, forKey: .flavorTextEntries)
        pokemon = try container.decode([PokemonForAbility].self, forKey: .pokemon)
        let generationNameUrl = try container.decode(NameUrlPair.self, forKey: .generation)
        generation = generationNameUrl.name
    }
}

struct Name: Decodable {
    let language: String            //NameUrlPair
    let value: String               //let name: String
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case language
        case value = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: .value)
        let languageNameUrl = try container.decode(NameUrlPair.self, forKey: .language)
        language = languageNameUrl.name
    }
}

struct EffectEntry: Decodable {
    let effect: String
    let language: String            //NameUrlPair
    let shortEffect: String?        // HINT: - decodeIfPresent
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case effect
        case language = "language"
        case shortEffect = "short_effect"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        effect = try container.decode(String.self, forKey: .effect)
        shortEffect = try container.decodeIfPresent(String.self, forKey: .shortEffect)
        let languageNameUrl = try container.decode(NameUrlPair.self, forKey: .language)
        language = languageNameUrl.name
    }
}

struct EffectChange: Decodable {
    let effectEntries: [EffectEntry]
    let versionGroup: String        //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    
    private enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case versionGroup = "version_group"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        effectEntries = try container.decode([EffectEntry].self, forKey: .effectEntries)
        let versionGroupNameUrl = try container.decode(NameUrlPair.self, forKey: .versionGroup)
        versionGroup = versionGroupNameUrl.name
    }
}

struct FlavorTextEntry: Decodable {
    let flavorText: String
    let language: String            //NameUrlPair
    let versionGroup: String        //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flavorText = try container.decode(String.self, forKey: .flavorText)
        let languageNameUrl = try container.decode(NameUrlPair.self, forKey: .language)
        language = languageNameUrl.name
        let versionGroupNameUrl = try container.decode(NameUrlPair.self, forKey: .versionGroup)
        versionGroup = versionGroupNameUrl.name
    }
}

struct PokemonForAbility: Decodable {
    let isHidden: Bool
    let pokemon: String             //NameUrlPair
    let slot: Int
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon
        case slot
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
        slot = try container.decode(Int.self, forKey: .slot)
        let pokemonNameUrl = try container.decode(NameUrlPair.self, forKey: .pokemon)
        pokemon = pokemonNameUrl.name
    }
}

/*** 6 ***/

// Complete result typealias' here
typealias AbilityListResult = Result<AbilityList, ServiceCallError>
typealias AbilityResult = Result<Ability, ServiceCallError>

final class AbilityServiceClient {
    private let baseServceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServceClient = baseServceClient
        self.urlProvider = urlProvider
    }

    /*** 7 ***/
    
    // Complete problem 6 before beginning this section so that the real function signature may be un-commented
    func getAbilityList(completion: @escaping (AbilityListResult) -> ()) {//(completion: @escaping (AbilityListResult) -> ()) {
        let pathComponents = ["ability"]
        let parameters = ["offset": "\(0)", "limit": "\(293)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
        baseServceClient.get(from: url) { (result) in
            switch result {
            case .success(let data):
                guard let abilityList = try? JSONDecoder().decode(AbilityList.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse json", code: nil)))
                    return
                }
                
                completion(.success(abilityList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /*** 8 ***/
    
    // Complete problem 6 before beginning this section so that the real function signature may be un-commented
    func getAbility(id: Int, completion: @escaping (AbilityResult) -> ()) {//(id: Int, completion: @escaping (AbilityResult) -> ()) {
        let pathComponents = ["ability", "\(id)"]
        let parameters: [String: String] = [:]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
        baseServceClient.get(from: url) { (result) in
            switch result {
            case .success(let data):
                guard let ability = try? JSONDecoder().decode(Ability.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse json", code: nil)))
                    return
                }
                
                completion(.success(ability))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
