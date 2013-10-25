//
//  KRAsyncImageView.m
//  Phonic
//
//  Created by Bai-Kai-Ren on 13/5/20.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRAsyncImageView.h"

@interface KRAsyncImageView()
{
    int isLoading;
}

@property (nonatomic, strong) NSURLConnection			*connection;
@property (nonatomic, strong) NSMutableData				*data;
@property (nonatomic, strong) UIActivityIndicatorView	*spinner;
@property (nonatomic, strong) NSString					*filePath;
@property (nonatomic, strong) NSString					*imageType;

@property (nonatomic, assign) BOOL	isInResuableCell;

@end

@implementation KRAsyncImageView {
    
}

@synthesize imageId, imageUrl, imageIdKey, imageSize;
@synthesize connection, data, spinner, filePath, imageType, isInResuableCell;


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setup];
        isLoading = NO;
        self.userInteractionEnabled = YES;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setup];
        isLoading = NO;
        self.userInteractionEnabled = YES;
	}
	return self;
}

-(void) addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)setup {
    
	self.imageType = @"";
	self.imageSize = KRAsyncImageSizeThumbnail;
	
	self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	spinner.frame = self.frame;
	spinner.center = self.center;
	spinner.hidesWhenStopped = TRUE;
	
	CALayer *layer = self.layer;
	layer.cornerRadius = 10;
	self.clipsToBounds = TRUE;
}

- (void)setImageSize:(int)aSize {
	self.filePath = nil;
	imageSize = aSize;
}

- (void)setImageId:(NSString *)anId {
	
	imageId = anId;
	
	NSFileManager *fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:[self filePath]]) {
		if ([imageType length] && !isInResuableCell) {
			self.image = [[UIImage alloc] initWithContentsOfFile:[self filePath]];
		} else {
			self.image = [UIImage imageWithContentsOfFile:[self filePath]];
		}
        
		[self setNeedsDisplay];
	} else {
		[self downloadImage];
	}
}

- (void)setImageUrl:(NSString *)url {
    
	if (!url) {
		self.isInResuableCell = TRUE;
		[connection cancel];
		imageId = nil;
		imageUrl = nil;
		self.filePath = nil;
		self.image = nil;
		return;
	}
    
	imageUrl = url;
	
	NSArray *urlParts = [url componentsSeparatedByString:@"?"];
	
	if ([urlParts count] < 2) {
		[self processFullPathURL];
	} else {
		[self processQueryURL:[urlParts objectAtIndex:1]];
	}
}

- (void)processFullPathURL {
	NSArray *pathParts = [imageUrl componentsSeparatedByString:@"/"];
	NSString *filePart = [pathParts lastObject];
	NSArray *fileParts = [filePart componentsSeparatedByString:@"."];
	
	if ([fileParts count] == 2) {
		self.imageType = [fileParts objectAtIndex:1];
	}
    
	self.imageId = [fileParts objectAtIndex:0];
}

- (void)processQueryURL:(NSString*)query {
    
	if (!imageIdKey || [imageIdKey length] == 0) {
		self.imageIdKey = defaultImageIdKey;
	}
	
	NSArray *queryParts = [query componentsSeparatedByString:@"&"];
	for (NSString *param in queryParts) {
		if ([param hasPrefix:[NSString stringWithFormat:@"%@=", imageIdKey]]) {
			NSArray *paramParts = [param componentsSeparatedByString:@"="];
			if ([paramParts count] == 2) {
				self.imageId = [paramParts objectAtIndex:1];
			}
		}
	}
    
	if (!imageId)
    {
        [self downloadImage];
    }
}

- (void)downloadImage
{
	[self.superview addSubview:spinner];
	[spinner startAnimating];
    
	self.data = [NSMutableData data];
	NSURL *url = [NSURL URLWithString:imageUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection	didReceiveData:(NSData *)incrementalData
{
    if (!data) self.data = [NSMutableData data];
    [data appendData:incrementalData];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	NSString *url = theConnection.currentRequest.URL.absoluteString;
	NSString *msg = [NSString stringWithFormat:@"Error:\n%@\n\nWith this url:\n%@", [error description], url];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Download Error" message:msg delegate:self cancelButtonTitle:@"Bummer" otherButtonTitles:nil];
	[alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection
{
	[spinner stopAnimating];
	self.connection = nil;
	
	if ([theConnection.currentRequest.URL.absoluteString isEqualToString:imageUrl])
    {
        
        CATransition *transition = [CATransition animation];
        
        transition.duration = 1.0;
        transition.type = @"rippleEffect";
        [self.layer addAnimation:transition forKey:nil];
        
		self.image = [UIImage imageWithData:data];;
		[self setNeedsLayout];
		isLoading = YES;
        
		if ([imageId length] > 0) {
            if(self.needSave)
            {
                [data writeToFile:[self filePath] atomically:TRUE];
            }
        }
	}
    
	self.data = nil;
}

- (NSString*)fileName {
    
	if (!imageId) return @"";
	
	if (imageSize == KRAsyncImageSizeThumbnail) return [NSString stringWithFormat:@"thumb_%@%@%@", imageId, ([imageType length])? @"." : @"", imageType];
	if (imageSize == KRAsyncImageSizeRegular)	return [NSString stringWithFormat:@"small_%@%@%@", imageId, ([imageType length])? @"." : @"", imageType];
	if (imageSize == KRAsyncImageSizeLarge)		return [NSString stringWithFormat:@"large_%@%@%@", imageId, ([imageType length])? @"." : @"", imageType];
    
	return @"";
}

- (NSString*)filePath {
    
	if (!filePath) {
		NSString *imageCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		self.filePath = [imageCachePath stringByAppendingPathComponent:[self fileName]];
	}
	return filePath;
}

- (void)dealloc {
    [connection cancel];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self.target respondsToSelector:self.action] && isLoading)
    {
        [self.target performSelector:self.action withObject:self afterDelay:0];
    }
}

@end
