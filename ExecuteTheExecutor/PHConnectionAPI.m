//
//  PHConnectionAPI.m
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/10/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import "PHConnectionAPI.h"

@implementation PHConnectionAPI
-(void)makeConnection
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lyrics.com/user/api/1621900/337d3a612f71f1e25a14aba07cab58fb/top_tracks/100"]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void(NSURLResponse *incomingResponse, NSData *incomingData, NSError *theirError)
                             {
                                 if (theirError)
                                 {
                                     NSLog(@"%@", theirError);
                                 }
                                 //Allocate stuff for block here
                                 NSDictionary *jsonDictionary = [[NSDictionary alloc]init];
                                 NSArray *songResults = [[NSArray alloc]init];
                                 NSDictionary *songForGame = [[NSDictionary alloc]init];
                                 id jsonObject = [NSJSONSerialization JSONObjectWithData:incomingData
                                                                                  options:NSJSONReadingAllowFragments
                                                                                    error:&theirError];
                                 jsonDictionary = (NSDictionary*)jsonObject;
                                 songResults = [jsonDictionary valueForKey:@"results"];
                                 songForGame = [self findShorterSongFrom:songResults];
                                 NSLog(@"%@", songForGame);
                                 [[self bitch] hasData:songForGame];
                             }];
}

-(NSDictionary*)findShorterSongFrom:(NSArray*)songResults
{
    int randomNumber = arc4random()%100;
    NSDictionary *songForGame = [[NSDictionary alloc]init];
    songForGame = [songResults objectAtIndex:randomNumber];
    if ([[songForGame valueForKey:@"song"] length]>18)
    {
        [self findShorterSongFrom:songResults];
    }
      return songForGame;
}

@end
