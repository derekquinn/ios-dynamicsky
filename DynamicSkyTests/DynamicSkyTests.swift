@testable import DynamicSky
import XCTest
import OHHTTPStubsSwift
import OHHTTPStubs
import CoreLocation

class DynamicSkyTests: XCTestCase {

    func testZipCodeValidation() throws {

        let validZipCodes = ["44720", "95959", "10011"]
        let invalidZipCodes = ["lasd", "33", "77"]

        for zipCode in validZipCodes {
            XCTAssertEqual(true, ValidationHelper.isZipCodeValid(zipCode: zipCode))
        }

        for zipCode in invalidZipCodes {
            XCTAssertFalse(ValidationHelper.isZipCodeValid(zipCode: zipCode))
        }
    }

    func testZipCodeSearchMakesRequestWithZipCodeAndDecodesSuccessfulResponse() {
        let expectedZip = "44720"
        stub(condition: isHost("api.openweathermap.org")) { request in
          XCTAssert(request.url!.absoluteString.contains("zip=" + expectedZip))
          let stubPath = OHPathForFile("zipresponse.json", type(of: self))
          return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "Callback completed successfully")

        OpenWeatherService.request(.currentWeatherWithZip(zipCode: expectedZip), completion: { (result: OpenWeatherSearchResponse) in
            
            XCTAssertEqual(result.name, "North Canton")
            XCTAssertEqual(result.searchResults?.temp, 49.3)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 0.3, handler: .none)
        HTTPStubs.removeAllStubs()
    }

    func testUserLocationSearch() {
        stub(condition: isHost("api.openweathermap.org")) { _ in
          let stubPath = OHPathForFile("coordinateresponse.json", type(of: self))
          return fixture(filePath: stubPath!, headers: ["Content-Type":"applicatn"])
        }

        let expectation = self.expectation(description: "Callback completed successfully")
        let coordinates = CLLocationCoordinate2D(latitude: 42.3354, longitude: -83.0492)

        OpenWeatherService.request(.currentWeatherWithCoordinates(coordinates: coordinates)) { (result: OpenWeatherSearchResponse) in
            XCTAssertEqual(result.name, "Detroit")
            XCTAssertEqual(result.searchResults?.temp, 48.47)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.3, handler: .none)
        HTTPStubs.removeAllStubs()
    }
}
