//
//  PHRules.m
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/9/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import "PHRules.h"

@implementation PHRules

-(NSString*)compareGuessTo:(NSString*)winningSong
         andCompare:(NSString*)letterGuessed
   andVerifyGuesses:(int)numberOfGuessesLeft
andAdjustHiddenSong:(NSString*)hiddenSong

{
    if (letterGuessed.length==1 && numberOfGuessesLeft>0)
    {
        NSRange rangeOfGuess = [winningSong rangeOfString:letterGuessed];
        if (rangeOfGuess.location != NSNotFound) {
            NSMutableString *newHiddenString = [hiddenSong mutableCopy];
            [newHiddenString replaceCharactersInRange:rangeOfGuess withString:letterGuessed];
        }
    }
    
    //Allocate all the objects!!
    int lengthOfCharacters = winningSong.length;
    NSRange guessedRange;
    //BOOL correctGuess = NO;
    
    //Make sure that only one letter is guessed and the user has guesses left
    if (letterGuessed.length==1 && numberOfGuessesLeft>0)
    {
        
        //loop through all letters in the winning Song and search for matches
        for (int i = 0; i<winningSong.length; i++)
        {
            //rangeOfNewWord is used in guessedRange
            self.rangeOfNewWord = NSMakeRange(i, lengthOfCharacters-i);
            //This takes the letterGuessed and compares it against the winningSong
            guessedRange = [winningSong rangeOfString:letterGuessed
                                                   options:NSCaseInsensitiveSearch
                                                     range:self.rangeOfNewWord];
            //The range contains a location and a length,
            //if there was a match, the guessedRange.length would be equal to 1
            if (guessedRange.length ==1)
            {
                hiddenSong = [self changeHiddenSong:hiddenSong atRange:guessedRange withLetter:letterGuessed];
                //correctGuess = YES;
            }
        }
    }

    return  hiddenSong;    
}

-(NSString*)changeHiddenSong:(NSString*)hiddenSong
                     atRange:(NSRange)guessRange
                  withLetter:(NSString*)guessedLetter
{
    hiddenSong = [hiddenSong stringByReplacingCharactersInRange:guessRange
                                                     withString:guessedLetter];
    return hiddenSong;
}

//-(NSString*)loopThroughCharactersIn:(NSString*)phrase
//                 andChangeInto:(NSString*)aCharacter;
//{
//    NSRange phraseRanage;
//    for (int i = 0; i<phrase.length; i++)
//    {
//        self.rangeOfNewWord = NSMakeRange(i, phrase.length-i);
//        phraseRanage = [phrase rangeOfString:aCharacter
//                                     options:NSCaseInsensitiveSearch
//                                       range:self.rangeOfNewWord];
//        
//        if (phraseRanage.length ==1)
//        {
//            phrase = [self changeCharactersIn:phrase atRange:phraseRanage with:aCharacter];
//        }
//    }
//    return phrase;
//}
//
//-(NSString*)changeCharactersIn:(NSString*)phrase
//                     atRange:(NSRange)phraseRange
//                  with:(NSString*)character
//{
//    phrase = [phrase stringByReplacingCharactersInRange:phraseRange
//                                                     withString:character];
//    return phrase;
//}

-(NSURLRequest*)createURLRequestFromString:(NSString*)urlString
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    return request;
}

@end
