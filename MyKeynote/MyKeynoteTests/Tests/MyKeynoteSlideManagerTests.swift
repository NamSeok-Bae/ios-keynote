//
//  MyKeynoteSlideManagerTests.swift
//  MyKeynoteTests
//
//  Created by 배남석 on 2023/07/24.
//

import XCTest

final class MyKeynoteSlideManagerTests: XCTestCase {
    var slideManager: MockSlideManager!
    
    override func setUp() async throws {
        slideManager = MockSlideManager()
        slideManager.createSquareSlide()
        slideManager.createImageSlide()
    }
    
    override func tearDown() async throws {
        slideManager = nil
    }
    
    func test_SquareSlide_Create() {
        let slideManager = MockSlideManager()
        slideManager.createSquareSlide()
        let newSlide: SquareSlide? = slideManager[0]
        guard let newSlide else {
            XCTFail("SquareSlide 생성 함수가 잘못됨.")
            return
        }
        
        XCTAssertEqual(newSlide, SquareSlide(identifier: "Square",
                                             alpha: 10,
                                             sideLength: 100,
                                             backgroundColor: SlideColor(red: 10,
                                                                         green: 10,
                                                                         blue: 10)))
    }
    
    func test_ImageSlide_Create() {
        let slideManager = MockSlideManager()
        slideManager.createImageSlide()
        let newSlide: ImageSlide? = slideManager[0]
        guard let newSlide else {
            XCTFail("ImageSlide 생성 함수가 잘못됨.")
            return
        }
        
        XCTAssertEqual(newSlide, ImageSlide(identifier: "Image",
                                            alpha: 10))
    }
    
    func test_Slide_Alpha_Update_0과10사이() {
        let slide: SquareSlide? = slideManager[0]
        guard let slide else {
            XCTFail("Subscript가 잘못됨.")
            return
        }
        XCTAssertEqual(slide.alpha.value, 10)
        
        slide.updateAlpha(alpha: 5)
        XCTAssertEqual(slide.alpha.value, 5)
    }
    
    func test_Slide_Alpha_Update_10초과() {
        let slide: SquareSlide? = slideManager[0]
        guard let slide else {
            XCTFail("Subscript가 잘못됨.")
            return
        }
        XCTAssertEqual(slide.alpha.value, 10)
        
        slide.updateAlpha(alpha: 15)
        XCTAssertEqual(slide.alpha.value, 10)
    }
    
    func test_Slide_Alpha_Update_0미만() {
        let slide: SquareSlide? = slideManager[0]
        guard let slide else {
            XCTFail("Subscript가 잘못됨.")
            return
        }
        XCTAssertEqual(slide.alpha.value, 10)
        
        slide.updateAlpha(alpha: -3)
        XCTAssertEqual(slide.alpha.value, 0)
    }
    
    func test_SquareSlide_BackgroundColor_Update_색깔범위가_255초과() {
        let slide: SquareSlide? = slideManager[0]
        guard let slide else {
            XCTFail("Subscript가 잘못됨.")
            return
        }
        XCTAssertEqual(slide.backgroundColor, SlideColor(red: 10, green: 10, blue: 10))
        
        slide.updateBackgroundColor(color: SlideColor(red: 300, green: 300, blue: 300))
        XCTAssertEqual(slide.backgroundColor, SlideColor(red: 255, green: 255, blue: 255))
        
    }
    
    func test_SquareSlide_BackgroundColor_Update_색깔범위가_0미만() {
        let slide: SquareSlide? = slideManager[0]
        guard let slide else {
            XCTFail("Subscript가 잘못됨.")
            return
        }
        XCTAssertEqual(slide.backgroundColor, SlideColor(red: 10, green: 10, blue: 10))
        
        slide.updateBackgroundColor(color: SlideColor(red: -1, green: -1, blue: -1))
        XCTAssertEqual(slide.backgroundColor, SlideColor(red: 0, green: 0, blue: 0))
    }
    
    func test_SquareSlide_BackgroundColor_Update_색깔범위가_0과255사이() {
        let slide: SquareSlide? = slideManager[0]
        guard let slide else {
            XCTFail("Subscript가 잘못됨.")
            return
        }
        XCTAssertEqual(slide.backgroundColor, SlideColor(red: 10, green: 10, blue: 10))
        
        slide.updateBackgroundColor(color: SlideColor(red: 100, green: 255, blue: 0))
        XCTAssertEqual(slide.backgroundColor, SlideColor(red: 100, green: 255, blue: 0))
    }
}
