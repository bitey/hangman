//
//  PHViewController.h
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/7/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHAPIDelegate.h"

@interface PHViewController : UIViewController <PHAPIDelegate, UITextFieldDelegate>

//-(void)startNewGame;

-(void)hasData:(NSDictionary *)songToUse;

@end
