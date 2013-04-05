//
//  PHConnectionAPI.h
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/10/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHAPIDelegate.h"
@interface PHConnectionAPI : NSObject

@property (strong, nonatomic) id<PHAPIDelegate>bitch;

-(void)makeConnection;

@end
