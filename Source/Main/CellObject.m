#import "CellObject.h"


@implementation CellObject

@synthesize label1=_label1;
@synthesize label2=_label2;
@synthesize label3=_label3;
@synthesize image=_image;

+ (CellObject *)cellObjectWithLabel1:(NSString *)label1 label2:(NSString *)label2
{
	CellObject *object = [[[CellObject alloc]init]autorelease];
	object.label1 = label1;
	object.label2 = label2;
	
	return object;
}

+ (CellObject *)cellObjectWithLabel1:(NSString *)label1 label2:(NSString *)label2 label3:(NSString *)label3 image:(UIImage *)image
{
	CellObject *object = [CellObject cellObjectWithLabel1:label1 label2:label2];
	object.label3 = label3;
	object.image = image;
	
	return object;
}


- (void)dealloc
{
	[_label1 release];
	[_label2 release];
	[_label3 release];
	[_image release];
	
	[super dealloc];
}

@end
