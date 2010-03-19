#import <Foundation/Foundation.h>


@interface CellObject : NSObject {
	NSString *_label1;
	NSString *_label2;
	NSString *_label3;
	UIImage *_image;
}

@property (nonatomic, retain) NSString *label1;
@property (nonatomic, retain) NSString *label2;
@property (nonatomic, retain) NSString *label3;
@property (nonatomic, retain) UIImage *image;

+ (CellObject *)cellObjectWithLabel1:(NSString *)label1 label2:(NSString *)label2;
+ (CellObject *)cellObjectWithLabel1:(NSString *)label1 label2:(NSString *)label2 label3:(NSString *)label3 image:(UIImage *)image;

@end
