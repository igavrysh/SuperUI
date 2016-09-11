//
//  IDPImageModel.m
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPGCDQueue.h"

#import "NSFileManager+IDPExtensions.h"

#import "IDPMacros.h"

@interface IDPImageModel ()
@property (nonatomic, strong)   UIImage     *image;
@property (nonatomic, strong)   NSURL       *url;

- (void)dump;

- (NSString *)localPathForURL:(NSURL *)url;

- (UIImage *)loadImageWithURL:(NSURL *)url;

- (UIImage *)loadImageWithFilePath:(NSString *)path;

@end

@implementation IDPImageModel

@dynamic localURL;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    return self.url;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    UIImage *image = [self loadImageWithFilePath:[self localPathForURL:self.url]];
    
    if (!image) {
        image = [self getImageWithURL:self.url];
    }
    
    self.image = image;
    
    self.state = IDPModelDidLoad;
}

- (UIImage *)getImageWithURL:(NSURL *)url {
    UIImage *image = [self loadImageWithURL:url];
    
    [self saveImage:image withFilePath:[self localPathForURL:url]];
    
    return image;
}

- (void)saveImage:(UIImage *)image withFilePath:(NSString *)path {
    NSError *error;
    NSString *directoryPath = [path stringByDeletingLastPathComponent];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:directoryPath]) {
        [manager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSString * extension = [path.pathExtension lowercaseString];
    if ([extension isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:path options:NSAtomicWrite error:&error];
    } else if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:path options:NSAtomicWrite error:&error];
    }
}

- (UIImage *)loadImageWithURL:(NSURL *)url {
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    return [UIImage imageWithData:data];
}

- (UIImage *)loadImageWithFilePath:(NSString *)path {
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    return [UIImage imageWithData:data];
}

- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)localPathForURL:(NSURL *)url {
    NSString *cachePath = [NSFileManager cachesPath];
    NSString *host = [url.host stringByReplacingOccurrencesOfString:@"." withString:@"/"];
    NSString *relativePath = url.relativePath;
    
    return [NSString stringWithFormat:@"%@/images/%@%@", cachePath, host, relativePath ];
}

@end
