//
//  PHRules.h
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/9/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHRules : NSObject

@property (assign, nonatomic) NSRange rangeOfNewWord;

-(NSString*)compareGuessTo:(NSString*)winningSong
           andCompare:(NSString*)letterGuessed
     andVerifyGuesses:(int)numberOfGuessesLeft
  andAdjustHiddenSong:(NSString*)hiddenSong;

-(NSString*)changeHiddenSong:(NSString*)hiddenSong
                     atRange:(NSRange)guessRange
                  withLetter:(NSString*)guessedLetter;
//
//-(NSString*)loopThroughCharactersIn:(NSString*)phrase
//                      andChangeInto:(NSString*)aCharacter;
//
//-(NSString*)changeCharactersIn:(NSString*)phrase
//                       atRange:(NSRange)phraseRange
//                          with:(NSString*)character;

-(NSURLRequest*)createURLRequestFromString:(NSString*)urlString;

@end
