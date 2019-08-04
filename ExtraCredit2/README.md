## Overview

You will be using the `BaseServiceClient` and `UrlProvider` created in class, alongside custom decoding initializers for the types provided, to create two service clients for various [PokéApi](https://pokeapi.co/docs/v2.html/) endpoints. Follow the instructions listed below to solve the problems given in this project.

---

## Problems 1-4: `BerryServiceClient`

Work for these problems should be completed in the `BerryServiceClient` class provided in the **Service** directory of this project.

### Problem 1 (10 points)

- For each struct `BerryList`, `Berry`, and `BerryFlavorMap`, write a **nested**, **private enum** `CodingKeys` subclassed as both `String` and `CodingKey` that contains a case for every attribute of the respective struct
- Write a custom `init(from decoder: Decoder)` function for each struct that decodes and initializes that struct from data
- Guidelines:
    - **DO NOT** change the names or types of any of properties of the structs provided
    - For `BerryList`; `items` should be _mapped_ to the `URL` values derived from decoding the `results` field of the data as an `[NameUrlPair]`
    - For `Berry`; `firmness`, `item`, and `naturalGiftType` should each be decoded as a `NameUrlPair` and set using the `name` property of the decoded object
    - For `BerryFlavorMap`; `flavor` should be decoded as a `NameUrlPair` and set using the `name` property of the decoded object

### Problem 2 (3 points)

- Write a `Result` type for each `typealias` provided
- Guidelines:
    - `BerryListResult` should return a type of `BerryList` for a success case, and a type of `ServiceCallError` for a failure case
    - `BerryResult` should return a type of `Berry` for a success case, and a type of `ServiceCallError` for a failure case

### Problem 3 (7 points)

- Complete the function `getBerryList` to utilize `BaseServiceClient` to retrieve a `BerryList` object from the specified `URL`
- Guidelines:
    - The function should accept a `completion` argument consisting of a closure `@escaping (BerryListResult) -> ()`
    - The function should attempt to decode a `BerryList` object from the data returned after `BaseServiceClient` completes a **get request**. The function should call `completion` with a `.failure()` case in the event the decoding is unsuccessful, and with a `.success()` case in the event the decoding succeeds. If the service call fails, complete with the returned error

### Problem 4 (7 points)

- Complete the function `getBerry` to utilize `BaseServiceClient` to retrieve a `Berry` object from the specified `URL`
- Guidelines:
    - The function should accept a `completion` argument consisting of a closure `@escaping (BerryResult) -> ()`
    - The function should attempt to decode a `Berry` object from the data returned after `BaseServiceClient` completes a **get request**. The function should call `completion` with a `.failure()` case in the event the decoding is unsuccessful, and with a `.success()` case in the event the decoding succeeds. If the service call fails, complete with the returned error

---

## Problems 5-8: `AbilityServiceClient`

Work for these problems should be completed in the `AbilityServiceClient` class provided in the **Service** directory of this project.

### Problem 5 (16 points)

- For each struct `AbilityList`, `Ability`, `Name`, `EffectEntry`, `EffectChange`, `FlavorTextEntry`, and `PokemonForAbility`, write a **nested**, **private enum** `CodingKeys` subclassed as both `String` and `CodingKey` that contains a case for every attribute of the respective struct
- Write a custom `init(from decoder: Decoder)` function for each struct that decodes and initializes that struct from data
- Guidelines:
    - **DO NOT** change the names or types of any of properties of the structs provided
    - For `AbilityList`; `items` should be _mapped_ to the `URL` values derived from decoding the `results` field of the data as an `[NameUrlPair]`
    - For `Ability`; `generation` should be decoded as a `NameUrlPair` and set using the `name` property of the decoded object
    - For `Name`; `language` should be decoded as a `NameUrlPair` and set using the `name` property of the decoded object. `case value` in the `CodingKeys` enum for this struct should contain a `rawValue` of `"name"`
    - For `EffectEntry`; `language` should be decoded as a `NameUrlPair` and set using the `name` property of the decoded object. `decodeIfPresent` should be used to decode the `shortEffect` property
    - For `EffectChange`; `versionGroup` should be decoded as a `NameUrlPair` and set using the `name` property of the decoded object
    - For `FlavorTextEntry`; `language` and `versionGroup` should each be decoded as a `NameUrlPair` and set using the `name` property of the decoded object
    - For `PokemonForAbility`; `pokemon` should be decoded as a `NameUrlPair` and set using the `name` property of the decoded object

### Problem 6 (3 points)

- Write a `Result` type for each `typealias` provided
- Guidelines:
    - `AbilityListResult` should return a type of `AbilityList` for a success case, and a type of `ServiceCallError` for a failure case
    - `AbilityResult` should return a type of `Ability` for a success case, and a type of `ServiceCallError` for a failure case

### Problem 7 (7 points)

- Complete the function `getAbilityList` to utilize `BaseServiceClient` to retrieve a `AbilityList` object from the specified `URL`
- Guidelines:
    - The function should accept a `completion` argument consisting of a closure `@escaping (AbilityListResult) -> ()`
    - The function should attempt to decode a `AbilityList` object from the data returned after `BaseServiceClient` completes a **get request**. The function should call `completion` with a `.failure()` case in the event the decoding is unsuccessful, and with a `.success()` case in the event the decoding succeeds. If the service call fails, complete with the returned error

### Problem 8 (7 points)

- Complete the function `getAbility` to utilize `BaseServiceClient` to retrieve a `Ability` object from the specified `URL`
- Guidelines:
    - The function should accept a `completion` argument consisting of a closure `@escaping (AbilityResult) -> ()`
    - The function should attempt to decode a `Ability` object from the data returned after `BaseServiceClient` completes a **get request**. The function should call `completion` with a `.failure()` case in the event the decoding is unsuccessful, and with a `.success()` case in the event the decoding succeeds. If the service call fails, complete with the returned error  

---

## Reference

- The `NameUrlPair` struct can be found in the **Utilities** directory of this project
- Documentation for the endpoints can be found at [PokéApi](https://pokeapi.co/docs/v2.html/)'s official website. The endpoints include [berry](https://pokeapi.co/docs/v2.html/#berries-section) and [ability](https://pokeapi.co/docs/v2.html/#abilities)
- A **Postman Collection** consisting of up-to-date versions of all calls made to [PokéApi](https://pokeapi.co/docs/v2.html/) in class and for this assignment is included in this project repository
    - [Postman](https://www.getpostman.com/) is not a requirement. However, it can be downloaded [here](https://www.getpostman.com/downloads/) for any students wishing to utilize this handy piece of **free** software.
- For students without access to **Postman**, `json` files outlining the payloads for each endpoint can be found in the **Reference** directory of this project
- **Example App 3** branch [example-app-4-and-extra-credit-reference](https://github.com/gmhz7b/example_app_3/tree/example-app-4-and-extra-credit-reference) may be used for reference in completing this assignment
    - // WARNING: - The requirements for this assignment extend further than the material covered in the example app itself. There should be no direct copying and pasting
- The article [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types) from [Reading Assignment 4](https://umsl.instructure.com/courses/52863/assignments/251520) should be used as reference for completing this assignment

---

## A Note on Grading

- 60 Points available overall
- This assignment will be factored into overall project scores at the end of the semester (obviously only as extra credit)
- No late submissions will be accepted for this assignment. It must be submitted no later than **Monday August 5th at 5:30 PM**, no exceptions
- Individual problems will be graded as all-or-nothing. If it works, you get the points. If it doesn't, sorry 'boutcha