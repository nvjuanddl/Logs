//
//  LogsListService.swift
//  LogsTests
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import XCTest
@testable import Logs

class LogsListServiceTest: XCTestCase {
    
    static let logsListMockup = """
    {
      "results": [
        {
          "gender": "female",
          "name": {
            "title": "Miss",
            "first": "Ege",
            "last": "Erkekli"
          },
          "location": {
            "street": {
              "number": 3954,
              "name": "Şehitler Cd"
            },
            "city": "Ankara",
            "state": "Kırşehir",
            "country": "Turkey",
            "postcode": 60401,
            "coordinates": {
              "latitude": "79.1178",
              "longitude": "167.4670"
            },
            "timezone": {
              "offset": "-11:00",
              "description": "Midway Island, Samoa"
            }
          },
          "email": "ege.erkekli@example.com",
          "login": {
            "uuid": "46106517-8810-4d6b-9202-a97f932d693a",
            "username": "blackmouse612",
            "password": "1220",
            "salt": "Hhd3BSZi",
            "md5": "993ae0818cc50e6270a6f4f3e7bab16a",
            "sha1": "aef974f2f47c256e8b17c975ca560705f3eef998",
            "sha256": "c1bb1d868bd6b7a28c62518a22c5cbd910c2602c43766096cf1cfb93abb84f0d"
          },
          "dob": {
            "date": "1969-10-21T14:25:25.425Z",
            "age": 53
          },
          "registered": {
            "date": "2018-09-26T09:12:03.510Z",
            "age": 4
          },
          "phone": "(118)-452-6875",
          "cell": "(123)-824-6562",
          "id": {
            "name": "",
            "value": null
          },
          "picture": {
            "large": "https://randomuser.me/api/portraits/women/54.jpg",
            "medium": "https://randomuser.me/api/portraits/med/women/54.jpg",
            "thumbnail": "https://randomuser.me/api/portraits/thumb/women/54.jpg"
          },
          "nat": "TR"
        }
      ],
      "info": {
        "seed": "3f4c691409a58c19",
        "results": 1,
        "page": 1,
        "version": "1.3"
      }
    }
    """
    
    func testGetLogsList() {
        let request: URLRequest!
        do {
            request = try ExternalDataRouter.logsList(EmptyRequest()).asURLRequest()
        } catch {
            request = nil
            XCTFail(error.localizedDescription)
        }

        let serviceExpectation = expectation(description: "get logs list")
        ExternalDataManager.execute(request: request) { (result: ExternalDataResult<BaseResponse<[Log]>>) in
            switch result {
            case .success: XCTAssert(true)
            case .failure: XCTAssert(false)
            }
            serviceExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("exceeded timeout: \(error)")
            }
        }
    }
    
    func testLogsListModelWithMock() {
        guard let data = LogsListServiceTest.logsListMockup.data(using: .utf8) else {
            XCTFail("data doesn't exits")
            return
        }
        
        do {
            _ = try JSONDecoder().decode(BaseResponse<[Log]>.self, from: data)
            XCTAssert(true)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
