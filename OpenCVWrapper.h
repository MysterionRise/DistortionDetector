//
//  OpenCVWrapper.h
//  DistortionDetector
//
//  Created by Konstantin on 13/04/2019.
//  Copyright © 2019 Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+ (NSString *)openCVVersionString;

+ (UIImage *)toGray:(UIImage *)source;

+ (UIImage *)containsChessBoard:(UIImage *)input;

@end

NS_ASSUME_NONNULL_END
