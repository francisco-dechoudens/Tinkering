//
//  Restaurant.h
//  Weather
//
//  Created by Frankie on 9/15/14.
//  Copyright (c) 2014 Scott Sherwood. All rights reserved.
//

#import "JSONModel.h"

@interface Restaurant : JSONModel

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* menu;
@property (strong, nonatomic) NSString* city_id;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* menu_pdf;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* special_offers;
@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSString* featured_type;
@property (strong, nonatomic) NSString* menu_locu;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSString* rtgAmbience_streamId;
@property (strong, nonatomic) NSString* website;
@property (strong, nonatomic) NSString* comments_streamId;
@property (strong, nonatomic) NSString* rtgService_streamId;
@property (strong, nonatomic) NSString* rtgComida_streamId;
@property (strong, nonatomic) NSString* reservation_id;
@property (strong, nonatomic) NSString* url_post;
@property (strong, nonatomic) NSString* latitude;
@property (strong, nonatomic) NSString* longitude;
@property (strong, nonatomic) NSString* lunch_special;
@property (strong, nonatomic) NSString* post_modified;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* excerpt;
@property (strong, nonatomic) NSString* reservation_phone;
@property (strong, nonatomic) NSString* timing;
@property (strong, nonatomic) NSString* rating_average;
@property (strong, nonatomic) NSString* keywords;
@property (strong, nonatomic) NSString* is_featured;

@property (strong, nonatomic) NSArray* featuredImage;
@property (strong, nonatomic) NSArray* ambience;
@property (strong, nonatomic) NSArray* galleryImages_M;
@property (strong, nonatomic) NSArray* price;
@property (strong, nonatomic) NSArray* tags;
@property (strong, nonatomic) NSArray* local_elements;
@property (strong, nonatomic) NSArray* foodType;
@property (strong, nonatomic) NSArray* galleryImages_L;


@end


