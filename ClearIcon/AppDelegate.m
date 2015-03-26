//
//  AppDelegate.m
//  ClearIcon
//
//  Created by 河野 さおり on 2015/02/27.
//  Copyright (c) 2015年 Saori Kohno. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    IBOutlet NSImageView *imgIcn;
    IBOutlet NSImageView *imgTypIcn;
}

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate{
    NSArray *exeption;
}
    
- (id)init{
    self = [super init];
    if (self){
        exeption = [[NSArray arrayWithObjects:@"app",@"public.volume",@"public.unix-executable",nil]retain];
    }
    return self;
}

- (void)dealloc{
    [exeption release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - open file

//ドックアイコンへのドラッグアンドドロップ時
- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename{
    return YES;
}

- (void) application:(NSApplication *)sender openFiles:(NSArray *)filenames{
    //複数ファイルは拒否
    if (filenames.count == 1) {
        NSString *path = [filenames objectAtIndex:0];
        NSWorkspace *ws = [NSWorkspace sharedWorkspace];
        NSMutableString *ext = [NSMutableString stringWithString:[[path pathExtension]lowercaseString]];
        if ([ext isEqualToString:@""]) {
            NSString *uti = [ws typeOfFile:path error:nil];
            [ext setString:uti];
        }
        NSImage *img = [ws iconForFile:path];
        NSImage *typeImg = [ws iconForFileType:ext];
        [imgIcn setImage:img];
        if ([exeption indexOfObject:ext]==NSNotFound) {
            [imgTypIcn setImage:typeImg];
            //[ws setIcon:typeImg forFile:path options:0];
        } else {
            [imgTypIcn setImage:nil];
        }
    }
}

@end
