//
//  InterfaceController.m
//  WatchNav WatchKit Extension
//
//  Created by beihe on 11/23/14.
//  Copyright (c) 2014 beihe. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (nonatomic) int count;
@property (nonatomic, strong) NSURLConnection *connection2;
@property (nonatomic, strong) NSURLConnection *connection4;
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSString *str;
@end

@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        self.dict = [[NSMutableDictionary alloc] init];
        // Do any additional setup after loading the view, typically from a nib.
        [self magic2];
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (void)magic2 {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://pastebin.com/api/api_post.php"]];
    NSString *params = [[NSString alloc] initWithFormat:@"api_option=list&api_results_limit=5&api_dev_key=f4ace3850850f1311210671d075d06aa&api_user_key=effb5ca014660752552cd785849d43ac"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    self.connection2 = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)read:(NSString *)string {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pastebin.com/raw.php?i=%@", string]]];
    [request setHTTPMethod:@"GET"];
    self.connection4 = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)refreshUI:(NSString *)string {
    if (string.length > 500) {
        return;
    }
    [self asdf:[string componentsSeparatedByString:@","]];
}

- (void)asdf:(NSArray *)array {
    if (array.count == 0) {
        return;
    }
    self.label.text = [array objectAtIndex:0];
    [self performSelector:@selector(asdf:) withObject:[array subarrayWithRange:NSMakeRange(1, array.count -1)] afterDelay:5];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (connection == self.connection2) {
        NSRange r = [myString rangeOfString:@"</paste_key>"];
        NSString *b = [myString substringWithRange:NSMakeRange(20, r.location-20)];
        if ([self.dict objectForKey:b]) {
            return;
        }
        [self read:b];
        self.str = b;
    } else if (connection == self.connection4) {
        [self refreshUI:myString];
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}


@end
