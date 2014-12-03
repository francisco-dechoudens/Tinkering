//
//  JasperAndZotGameTests.m
//  JasperAndZotGameTests
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Board.h"

@interface JasperAndZotGameTests : XCTestCase

@end

@implementation JasperAndZotGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)test_setCellState_setWithValidCoords_cellStateIsChanged
{
    Board* board = [[Board alloc] init];
    
    // set the state of one of the cells
    [board setCellState:BoardCellStateZombiePiece forColumn:4 andRow:5];
    
    // verify
    BoardCellState retrievedState = [board cellStateAtColumn:4 andRow:5];
    XCTAssertEqual(BoardCellStateZombiePiece, retrievedState, @"The cell should have been zombie!");
}

- (void)test_setCellState_setWithInvalidCoords_exceptionWasThrown
{
    Board* board = [[Board alloc] init];
    
    @try {
        // set the state of a cell at an invalid coordinate
        [board setCellState:BoardCellStateFlowerPiece forColumn:10 andRow:5];
        
        // if an exception was not thrown, this line will be reached
        XCTFail(@"An exception should have been thrown!");
    }
    @catch (NSException* e) {
        
    }
}


@end
