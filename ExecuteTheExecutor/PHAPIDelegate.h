//
//  PHAPIDelegate.h
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/10/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PHAPIDelegate <NSObject>

@required
-(void)hasData:(NSDictionary*)songToUse;

@end
