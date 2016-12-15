//
//  AppDelegate.m
//  AutoNetModel
//
//  Created by quentin on 2016/12/15.
//  Copyright © 2016年 AM. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)onTapClick:(id)sender
{

    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Json" ofType:@"json"]]];
    NSLog(@"data %@", data);
    id value = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error == nil) {
        NSLog(@"dict == %@", value);
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:value];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

            if ([[obj lowercaseString] isEqualToString:@"bool"]) {
                NSLog(@"@property (nonatomic, assign) BOOL %@;/**<解释*/", key);
            }
            else if ([[obj lowercaseString] isEqualToString:@"nsstring"]) {
                NSLog(@"@property (nonatomic, copy) NSString %@;/**<解释*/", key);
            }
            else if ([[obj lowercaseString] isEqualToString:@"double"]) {
                NSLog(@"@property (nonatomic, assign) double %@;/**<解释*/", key);
            }
            else if ([[obj lowercaseString] isEqualToString:@"int"] ||
                     [[obj lowercaseString] isEqualToString:@"nsinteger"] ) {
                NSLog(@"@property (nonatomic, assign) NSInteger %@;/**<解释*/", key);
            }
            else if ([[obj lowercaseString] isEqualToString:@"dictionary"]) {
                NSLog(@"@property (nonatomic, strong) NSDictionary %@;/**<解释*/", key);
            }
            
        }];

    }
    else {
        NSLog(@"解析错误 %@", error);
    }
}

@end
