//
//  PHGameData.m
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/9/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//


//Possibly refactor with enumerateLinesUsingBlock

#import "PHGameData.h"

@implementation PHGameData

-(NSArray*)parseSpacesOutOfSong:(NSString*)winningSong
{
    self.winningSongWords = [[NSArray alloc]init];
    self.winningSongWords = [winningSong componentsSeparatedByString:@" "];
    
    return self.winningSongWords;
    //NSLog(@"%@", self.winningSongWords);
}

-(NSString*)obscureWordsIndividually:(NSArray*)separatedWords
{    
    //NSString *hiddenWinningSong = @"";
    //NSRange rangeOfWinningSong = NSMakeRange(0, winningSong.length);
    
    for (int i = 0; i<separatedWords.count; i++)
    {
        self.obscuredWord = [separatedWords objectAtIndex:i];
        self.obscuredWord = [self convertWordToUnderscore:self.obscuredWord];
    }
    return self.obscuredWord;
    
}
-(NSString*)convertWordToUnderscore:(NSString*)obscuredWord
{
    self.hiddenWinningSong = @"";
    for (int i = 0; i<obscuredWord.length; i++)
    {
        self.hiddenWinningSong = [self.hiddenWinningSong stringByAppendingFormat:@"_ "];
        NSLog(@"OBSCURED %@", self.hiddenWinningSong);
    }
    return self.hiddenWinningSong;
}
@end
