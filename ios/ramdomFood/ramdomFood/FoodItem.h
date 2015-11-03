//
//  FoodItem.h
//  ramdomFood
//
//  Created by jsong on 2015. 6. 22..
//  Copyright (c) 2015년 jsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject

@property NSString *foodName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
