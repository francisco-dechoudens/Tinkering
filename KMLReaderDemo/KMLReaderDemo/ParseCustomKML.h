//
//  ParseCustomKML.h
//  KMLReaderDemo
//
//  Created by Frankie on 7/31/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMXMLDocument.h"

@interface ParseCustomKML : NSObject
@property(nonatomic,weak)SMXMLDocument *document;
- (id)initWithData:(NSData *)data;
-(NSArray*)getVertexes;
-(NSArray*)getPlacemarks;
@end
